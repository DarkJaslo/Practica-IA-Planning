/*
    Programa para generar juegos de prueba aleatorios del planner
*/

#include <iostream>
#include <fstream>
#include <vector>
#include <random>
using namespace std;

// Union-find set.
class UnionFind {
private:
    vector<int> parent;
    vector<int> rank;

public:
    UnionFind(int n) {
        parent.resize(n);
        rank.resize(n, 0);
        // Initialize each element as a separate set
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }
    }

    // Find the root of the set to which x belongs (with path compression)
    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]); // Path compression
        }
        return parent[x];
    }

    // Union operation to merge two sets
    void unionSets(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);

        if (rootX != rootY) {
            if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else {
                parent[rootY] = rootX;
                rank[rootX]++;
            }
        }
    }

    bool same(int x, int y)
    {
        return find(x) == find(y);
    }
};

const vector<string> MESES = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
bool PRE_ON;
bool MULTIPRE_ON;
bool PAR_ON;
bool PAG_ON;
int N;
string ext; //Extensiones
vector<pair<int,int>> PRES;
vector<pair<int,int>> PARS;
vector<int> PAGS;
vector<vector<bool>> DAG;
vector<vector<bool>> PARALELO;
int PROB_PRE = 5;    //Sobre 100, se mira entre cada par ordenado
int PROB_PAR = 10;   //Sobre 100, afectan varios factores
int PROB_LEIDO = 10; //Sobre 100, se mira para cada libro
int PROB_LEER = 80;  //Sobre 100, se mira para cada libro no leido
long SEED;
//long SEED = 1704571405; //Provisional
//long SEED = time(NULL);
mt19937 gen;
uniform_int_distribution<int> distr;
vector<bool> QUIERE_LEER;
vector<bool> LEIDO;

/*
    Cuantos mas libros paralelos tengan A y B, menos probable es que se puedan juntar. Esto es importante, 
    porque la relacion es transitiva y en seguida se tienen grupos de 8 o 9 paralelos (demasiado forzado).
    En concreto, ahora es imposible que haya grupos de mas de 4 paralelos
    Se anima a que haya bastantes paralelos (prob "alta" si no tienen paralelos), pero no grandes agrupaciones 
    donde todos lo son.
*/
int probPar(int parA, int parB)
{
    int pars = (parA+1)+(parB+1); //Calculo de cuantos libros seran paralelos si se juntan estos dos
    int res = PROB_PAR - 3*pars;

    if(res < 0) return -1;
    return res;
}

/*
    Probabilidad nula si ya entran aristas en el nodo destino o si ya salen aristas del nodo origen
    Esto hace que no se generen todos los grafos, pero genera las dependencias mas "naturales" y se evitan grafos muy raros/facilmente incompatibles luego con los paralelos
*/
int probPre(int sale, int entra)
{
    if(sale >= 1 or entra >= 1) return -1;
    return PROB_PRE;
}

//Macro, entra una probabilidad y si el numero generado es menor devuelve cierto
//Por lo tanto, si prob=2 y randomN=1, cierto. Si randomN=13, falso.
bool rollRandom(int prob)
{
    int randomN = distr(gen);
    return randomN < prob;
}

void creaDAG()
{   
    //Generacion de numeros aleatorios
    gen = mt19937(SEED);
    distr = uniform_int_distribution<int>(0,99);

    /*
        Asignacion de prerrequisitos. Se construye un DAG, con el pseudocodigo siguiente:
        forall vertice u
            forall vertice v > u
                con cierta probabilidad, pon arista u->v
        
        Se aprovecha para guardar en un Union-Find los componentes conexos para mas tarde
        La probabilidad depende de las aristas que salen de u y de las aristas que entran en v
    */
    DAG = vector<vector<bool>>(N,vector<bool>(N,false));
    vector<int> numSalidas(N,0);
    vector<int> numEntradas(N,0);
    UnionFind accesibles(N);

    if(PRE_ON)
    {
        for(int i = 0; i < N; ++i)
        {
            //Si solo se puede tener un prerrequisito, hay que asegurar que no se encadenan mas
            if(not MULTIPRE_ON)
            {
                if(numSalidas[i] >= 1 or numEntradas[i] >= 1) continue;
            }

            for(int j = i+1; j < N; ++j)
            {       
                //Tampoco se conectan vertices que ya estan conectados de alguna otra forma     
                if(not accesibles.same(i,j) and rollRandom(probPre(numSalidas[i], numEntradas[j])))
                {
                    DAG[i][j] = true;
                    numSalidas[i]++;
                    numEntradas[j]++;
                    accesibles.unionSets(i,j);
                    PRES.push_back(make_pair(i,j));
                }  
            }
        }
    }

    /*
        Seleccion de libros paralelos.
        Se utiliza un Union-Find para guardar los diferentes componentes conexos (grupos de libros paralelos)
    */
    vector<int> numParalelos(N,0);
    UnionFind paralelos(N);

    if(PAR_ON)
    {
        for(int i = 0; i < N; ++i)
        {
            //j = i+1 para evitar dobles aristas
            for(int j = i+1; j < N; ++j)
            {
                //no pueden estar conectados por dependencias ni ser ya paralelos
                if(accesibles.same(i,j) or paralelos.same(i,j)) continue;

                /*
                    Se prueba que pasa si se hace el cambio (se pone la relacion de paralelos).
                    - Si esto causa indirectamente que haya algun par de libros relacionados por paralelos pero tambien por prerrequisitos, no se puede poner paralelo aqui
                    - Si no pasa, es seguro continuar
                */
                //Copia para poder deshacer el cambio
                UnionFind tempParalelos = paralelos;
                tempParalelos.unionSets(i,j);
                bool compatible = true;

                for(int k = 0; k < N; ++k)
                {
                    for(int l = 0; l < N; ++l)
                    {
                        if(k==l) continue;
                        if(tempParalelos.same(k,l) and accesibles.same(k,l)) //Incompatible
                        {
                            compatible = false;
                            break;
                        }
                    }

                    if(not compatible) break;
                }

                if(not compatible) continue;
                //Else,

                //Candidatos validos para ser paralelos. Ahora hay que tirar el dado
                if(not rollRandom(probPar(numParalelos[i],numParalelos[j]))) continue;

                //Se cumplen todas las condiciones
                PARS.push_back(make_pair(i,j));
                PARS.push_back(make_pair(j,i));
                paralelos.unionSets(i,j);

                /*
                    Para poder usar bien la funcion de probabilidad, hay que recalcular cuantos paralelos
                    tiene cada vertice.
                */
                vector<bool> visited(N,false);
                for(int i = 0; i < N; ++i)
                {
                    if(not visited[i])
                    {
                        int countParalelos = 0;
                        vector<int> indicesParalelos;
                        for(int j = i+1; j < N; ++j)
                        {
                            if(not paralelos.same(i,j)) continue;
                            //Else,

                            countParalelos++;
                            indicesParalelos.push_back(j);
                            visited[j] = true;
                        }

                        for(int index : indicesParalelos)
                            numParalelos[index] = countParalelos;
                        numParalelos[i] = countParalelos;

                        visited[i] = true;
                    }
                }
            }
        }

        /*
            Se ponen en una matriz las relaciones de paralelismo entre libros para mas tarde
        */
        PARALELO = vector<vector<bool>>(N,vector<bool>(N,false));
        for(int i = 0; i < N; ++i)
        {
            for(int j = 0; j < N; ++j)
            {
                if(i==j) continue;

                if(paralelos.same(i,j))
                    PARALELO[i][j] = true;
            }
        }
    }
    
    /*
        Asignacion de paginas.
        Si estan activadas, se asignan entre 0 y 300 paginas a cada libro.
        Si no, se asignan 0.
    */
    PAGS = vector<int>(N,0);
    if(PAG_ON)
    {
        for(int i = 0; i < N; ++i)
            PAGS[i] = (distr(gen)+1)*3;
    }

    /* 
        Seleccion de libros leidos. Con PROB_LEIDO, se escogen algunos libros sin prerrequisitos para que ya esten leidos.
    */
    LEIDO = vector<bool>(N,false);

    for(int i = 0; i < N; ++i)
    {
        bool accedido = false;
        for(int j = 0; j < i; ++j)
        {
            if(DAG[j][i])
            {
                accedido = true;
                break;
            }
        }
        if(accedido) continue;

        if(rollRandom(PROB_LEIDO))
        {
            LEIDO[i] = true;
        }
    }

    /*
        Seleccion de libros que se quieren leer.
        Con PROB_LEER, se escogen libros no leidos y se ponen como que se quieren leer.
    */
    QUIERE_LEER = vector<bool>(N,false);

    for(int i = 0; i < N; ++i)
    {
        if(not LEIDO[i] and rollRandom(PROB_LEER))
        {
            QUIERE_LEER[i] = true;
        }
    }
}

void printObjetos()
{
    for(int i = 0; i < N; ++i)
    {
        cout << "Libro" << i << " ";
    }
    cout << "- libro\n";
}

void printUniversalFacts()
{
    if(PAR_ON)
    {
        cout << "\t\t";
        cout << "(inm_anterior Casper Enero) ";
        for(int i = 0; i < MESES.size()-1; ++i)
        {
            cout << "(inm_anterior " << MESES[i] << " " << MESES[i+1] << ") ";
        }
        cout << "\n";
    }

    cout << "\t\t";
	for(int i = 0; i < MESES.size(); ++i)
	{
        for(int j = i+1; j < MESES.size(); ++j)
        {
            cout << "(anterior " << MESES[i] << " " << MESES[j] << ") ";
        }
	}
    cout << "\n";

    if(PAG_ON)
    {
        for(int i = 0; i < MESES.size(); ++i)
        {
            cout << "\t\t(= (paginas-leidas " << MESES[i] << ") 0)\n";
        }
    }
}

void printRelaciones()
{
    //Print leidos
    for(int i = 0; i < N; ++i)
    {        
        if(LEIDO[i])
        {
            cout << "\t\t(leido Libro" << i << ")\n";
        }
    }

    //Print quiere leer
    for(int i = 0; i < N; ++i)
    {
        if(QUIERE_LEER[i])
        {
            cout << "\t\t(quiere_leer Libro" << i << ")\n";
        }
    }

    //Print prerequisitos
    if(PRE_ON)
    {
        for(int i = 0; i < PRES.size(); ++i)
        {
            cout << "\t\t(predecesor Libro" << PRES[i].first << " Libro" << PRES[i].second << ")\n";
        }
    }

    //Print paralelos
    if(PAR_ON)
    {
        /* Printea solo las aristas necesarias */
        for(int i = 0; i < PARS.size(); ++i)
        {
            cout << "\t\t(paralelo Libro" << PARS[i].first << " Libro" << PARS[i].second << ")\n";
        }

        /* Printea todas las relaciones
        for(int i = 0; i < N; ++i)
        {
            for(int j = 0; j < N; ++j)
            {
                if(PARALELO[i][j])
                {
                    cout << "\t\t(paralelo Libro" << i << " Libro" << j << ")\n";
                }
            }
        }
        */
    }

    if(PAG_ON)
    {
        //Print paginas
        for(int i = 0; i < N; ++i)
        {
            cout << "\t\t(= (paginas Libro" << i << ") " << PAGS[i] << ")\n";
        }
    }
}

/*
    Imprime el grafo en formato DOT, para poderse visualizar
    https://stackoverflow.com/questions/13236975/graphviz-dot-mix-directed-and-undirected
*/
void printDOT()
{
    string filename = "grafos-";
    filename.append(ext);
    filename.append("/grafo");
    filename.append(std::to_string(N));
    filename.append(".dot");

    ofstream output(filename);
    output << "digraph {\n";

    output << "\t";
    for(int i = 0; i < N; ++i)
    {
        output << i << "; ";
    }
    output << "\n";

    if(PAR_ON)
    {
        output << "\tsubgraph Par {\n";
        output << "\t\tedge [dir=none, color=red]\n";

        /* Printea solo las aristas del problema
        for(int i = 0; i < PARS.size(); i+=2)
        {
            //if(PARS[i].first > PARS[i].second) continue;
            output << "\t\t" << PARS[i].first << " -> " << PARS[i].second << ";\n";
        }
        */

        /* Printea todas las aristas entre paralelos (preferible, se entiende mejor) */
        for(int i = 0; i < N; ++i)
        {
            for(int j = i+1; j < N; ++j)
            {
                if(PARALELO[i][j])
                {
                    output << "\t\t" << i << " -> " << j << ";\n";
                }
            }
        }

        output << "\t}\n\n";
    }

    if(PRE_ON)
    {
        output << "\tsubgraph Pre {\n";
        output << "\t\tedge [color=blue]\n";
        for(int i = 0; i < N; ++i)
        {
            for(int j = i+1; j < N; ++j)
            {
                if(DAG[i][j])
                {
                    output << "\t\t" << i << " -> " << j << ";\n";
                }
            }
        }
        output << "\t}\n";
        output << "}\n";
    }
}

void usage()
{
    cout << "Usage: ./juegos-prueba [N] [seed] [extensiones]\nN es el numero de libros\nHay que especificar una seed para los numeros aleatorios\nPara las extensiones, las opciones son:\nbasico\next1\next2\next3\n";
}

int main(int argc, char** argv)
{
    if(argc != 4)
    {
        usage();
        exit(1);
    }

    N = atoi(argv[1]);
    //string pre = string(argv[2]);
    //string par = string(argv[3]);
    //string pag = string(argv[4]);
    SEED = atol(argv[2]);
    ext = string(argv[3]);

    if(ext == "basico")
    {
        PRE_ON = true;
        MULTIPRE_ON = false;
        PAR_ON = false;
        PAG_ON = false;
    }
    else if(ext == "ext1")
    {
        PRE_ON = true;
        MULTIPRE_ON = true;
        PAR_ON = false;
        PAG_ON = false;
    }
    else if(ext == "ext2")
    {
        PRE_ON = true;
        MULTIPRE_ON = true;
        PAR_ON = true;
        PAG_ON = false;
    }
    else if(ext == "ext3")
    {
        PRE_ON = true;
        MULTIPRE_ON = true;
        PAR_ON = true;
        PAG_ON = true;
    }
    else
    {
        cerr << "La extension especificada, \"" << ext << "\", no esta en las opciones\n";
        exit(1);
    }

    cout << "; DEBUG: DAG con " << N << " libros:\n";
    cout << "; prerequisitos "; PRE_ON ? cout << "on" : cout << "off"; cout << "\n";
    cout << "; paralelos "; PAR_ON ? cout << "on" : cout << "off"; cout << "\n";
    cout << "; npaginas "; PAG_ON ? cout << "on" : cout << "off"; cout << "\n";

    creaDAG();

    cout << "; Fichero generado con el programa, seed " << SEED << "\n";
    cout << "(define (problem Libros-base)\n";
    cout << "\t(:domain Lectura)\n";
    cout << "\t(:objects\n";
    //meses
    cout << "\t\t"; 
    cout << "Casper" << " ";
    for(const string& mes : MESES)
        cout << mes << " ";
    cout << "- mes\n";
    //fin meses

    //objetos a continuacion
    cout << "\t\t";
    printObjetos();
    cout << "\t)\n"; //cierra parentesis objetos
    cout << "\n";    //linea en blanco

    cout << "\t(:init\n";

    cout << "\t\t; Datos universales\n";
	printUniversalFacts();

    cout << "\t\t; Relaciones entre objetos\n";
    printRelaciones();
    cout << "\t)\n";   //cierra init

    cout << "\n"; //linea en blanco

    cout << "\t(:goal\n";

    cout << "\t\t; Para todos los libros que se quieren leer, asignados.\n";
    cout << "\t\t(forall (?l - libro) (imply (quiere_leer ?l) (asignado ?l)))\n";

    cout << "\t)\n"; //cierra goal

    cout << ")\n"; //cierra fichero

    //Print grafo en STDERR
    printDOT();
}