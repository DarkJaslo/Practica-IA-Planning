/*
    Programa para generar juegos de prueba aleatorios del planner, by Jon Campillo
*/

#include <iostream>
#include <fstream>
#include <vector>
#include <random>
using namespace std;

// Union-find set implementation
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
bool PAR_ON;
bool PAG_ON;
int N;
vector<pair<int,int>> PRES;
vector<pair<int,int>> PARS;
vector<int> PAGS;
vector<vector<bool>> DAG;
vector<vector<bool>> PARALELO;
vector<vector<bool>> reach; //Matriz que indica si dos nodos estan conectados por algun camino
int PROB_PRE = 5;   //Sobre 100, se mira entre cada par ordenado
int PROB_PAR = 10;   //Sobre 100, se mira entre cada par no accesible mutuamente
int PROB_LEER = 80; //Sobre 100, se mira para cada libro
int PROB_LEIDO = 10; //Sobre 100, se mira para cada libro
long SEED = 1704571405;
//long SEED = time(NULL);
mt19937 gen;
uniform_int_distribution<int> distr;
vector<bool> QUIERE_LEER;
vector<bool> LEIDO;

int probPar(int parA, int parB)
{
    int pars = (parA+1)+(parB+1);
    int res = PROB_PAR - 3*pars;

    if(res < 0) return -1;
    return res;
}

int probPre(int sale, int entra)
{
    if(sale >= 1 or entra >= 1) return -1;
    return PROB_PRE;
    /*
    int res = PROB_PRE - 10*sale;
    if(res < 0) return -1;
    return res;
    */
}

bool rollRandom(int prob)
{
    int randomN = distr(gen);
    return randomN < prob;
}

void BFS(int nodo, vector<vector<bool>>& DAG, vector<vector<bool>>& reach, UnionFind& accesibles)
{
    for(int i = nodo+1; i < N; ++i)
    {
        if(DAG[nodo][i] and (accesibles.find(nodo) != accesibles.find(i)))
        {
            reach[nodo][i] = true;
            accesibles.unionSets(nodo,i);

            for(int j = 0; j < nodo; ++j)
            {
                if(reach[j][nodo])
                {
                    reach[j][i] = true;
                    reach[i][j] = true;
                }
            }

            reach[i][nodo] = true;
        }
    }
}

void creaDAG()
{   
    gen = mt19937(SEED);
    distr = uniform_int_distribution<int>(0,99);

    PAGS = vector<int>(N,0);
    
    DAG = vector<vector<bool>>(N,vector<bool>(N,false));
    vector<int> numSalidas(N,0);
    vector<int> numEntradas(N,0);
    UnionFind accesibles(N);

    //Crea dependencias
    if(PRE_ON)
    {
        for(int i = 0; i < N; ++i)
        {
            for(int j = i+1; j < N; ++j)
            {            
                if((accesibles.find(i) != accesibles.find(j)) and rollRandom(probPre(numSalidas[i], numEntradas[j])))
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

    reach = vector<vector<bool>>(N, vector<bool>(N,false));

    //Entre libros sin dependencias entre medio, pon paralelos
    PARALELO = vector<vector<bool>>(N,vector<bool>(N,false));
    vector<int> numParalelos(N,0);
    UnionFind paralelos(N);

    if(PAR_ON)
    {
        //Para los que no esten conectados, se puede poner paralelo
        for(int i = 0; i < N; ++i)
        {
            for(int j = i+1; j < N; ++j)
            {
                if(accesibles.same(i,j) or paralelos.same(i,j)) continue;

                //Check grande
                UnionFind tempParalelos = paralelos;
                tempParalelos.unionSets(i,j);
                bool compatible = true;

                for(int k = 0; k < N; ++k)
                {
                    for(int l = 0; l < N; ++l)
                    {
                        if(k==l) continue;
                        if(tempParalelos.same(k,l) and accesibles.same(k,l)) //Borra la cuenta
                        {
                            compatible = false;
                            break;
                        }
                    }

                    if(not compatible) break;
                }

                if(not compatible) continue;
                //Else,
                //Roll random
                if(not rollRandom(probPar(numParalelos[i],numParalelos[j]))) continue;

                //Se cumplen todas las condiciones

                PARS.push_back(make_pair(i,j));
                PARS.push_back(make_pair(j,i));

                //PARALELO[i][j] = true;
                //PARALELO[j][i] = true;

                paralelos.unionSets(i,j);

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

                        visited[i] = true;
                    }
                }

                /*numParalelos[i]++;
                numParalelos[j]++;

                for(int k = 0; k < N; ++k)
                {
                    if(k != j and PARALELO[i][k] and not PARALELO[j][k])
                    {
                        PARALELO[j][k] = true;
                        PARALELO[k][j] = true;
                        numParalelos[j]++;
                        numParalelos[k]++;
                        PARS.push_back(make_pair(j,k));
                        PARS.push_back(make_pair(k,j));
                    }
                    if(k != i and PARALELO[j][k] and not PARALELO[i][k])
                    {
                        PARALELO[i][k] = true;
                        PARALELO[k][i] = true;
                        numParalelos[i]++;
                        numParalelos[k]++;
                        PARS.push_back(make_pair(i,k));
                        PARS.push_back(make_pair(k,i));
                    }
                }

                */
            }
        }

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
    
    if(PAG_ON)
    {
        for(int i = 0; i < N; ++i)
            PAGS[i] = (distr(gen)+1)*3;
    }
    else
    {
        for(int i = 0; i < N; ++i)
            PAGS[i] = 0;
    }

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
    int printed = 0;
    for(int i = 0; i < N; ++i)
    {
        if(QUIERE_LEER[i])
        {
            cout << "Libro" << i << " "; 
            printed++;
        }
            
    }
    if(printed > 0) cout << "- quiereL\n";
    printed = 0;
    cout << "\t\t";

    for(int i = 0; i < N; ++i)
    {
        if(not QUIERE_LEER[i])
        {
            cout << "Libro" << i << " "; 
            printed++;
        }
            
    }

    if(printed > 0) cout << "- otrosL\n";
}

void printUniversalFacts()
{
    cout << "\t\t";
    cout << "(inm_anterior Casper Enero) ";
    for(int i = 0; i < MESES.size()-1; ++i)
    {
        cout << "(inm_anterior " << MESES[i] << " " << MESES[i+1] << ") ";
    }
    cout << "\n";

    cout << "\t\t";
	for(int i = 0; i < MESES.size(); ++i)
	{
        for(int j = i+1; j < MESES.size(); ++j)
        {
            cout << "(anterior " << MESES[i] << " " << MESES[j] << ") ";
        }
	}
    cout << "\n";

    for(int i = 0; i < MESES.size(); ++i)
    {
        cout << "\t\t(= (paginas-leidas " << MESES[i] << ") 0)\n";
    }
}

void printRelaciones()
{
    //aun no funciona bien
    //Print leidos
    for(int i = 0; i < N; ++i)
    {        
        if(LEIDO[i])
        {
            cout << "\t\t(leido Libro" << i << ")\n";
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
        
        for(int i = 0; i < PARS.size(); ++i)
        {
            cout << "\t\t(paralelo Libro" << PARS[i].first << " Libro" << PARS[i].second << ")\n";
        }

        /*
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

    for(int i = 0; i < N; ++i)
    {
        cout << "\t\t(= (paginas Libro" << i << ") " << PAGS[i] << ")\n";
    }
}

/*
    Imprime el grafo en formato DOT, para poderse visualizar
    https://stackoverflow.com/questions/13236975/graphviz-dot-mix-directed-and-undirected
*/
void printDOT()
{
    string filename = "grafos/grafo" + std::to_string(N) + ".dot";
    ofstream output(filename);
    output << "digraph {\n";

    output << "\t";
    for(int i = 0; i < N; ++i)
    {
        output << i << "; ";
    }
    output << "\n";

    output << "\tsubgraph Par {\n";
    output << "\t\tedge [dir=none, color=red]\n";
    /*for(int i = 0; i < PARS.size(); i+=2)
    {
        //if(PARS[i].first > PARS[i].second) continue;
        output << "\t\t" << PARS[i].first << " -> " << PARS[i].second << ";\n";
    }*/

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

void usage()
{
    cout << "Usage: ./juegos-prueba [N] [prerequisitos] [paralelos] [paginas]\nN es el numero de libros\nEn prerequisitos, paralelos y paginas, se pone \"on\" u \"off\" en cada campo, en funcion de si se quiere activar o no.\n";
}

int main(int argc, char** argv)
{
    if(argc != 5)
    {
        usage();
        exit(1);
    }

    N = atoi(argv[1]);
    //PROB_PRE = 200/((3*N)/2);
    //PROB_PAR = 200/((3*N)/2);
    string pre = string(argv[2]);
    string par = string(argv[3]);
    string pag = string(argv[4]);

    PRE_ON = pre=="on";
    PAR_ON = par=="on";
    PAG_ON = pag=="on";

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

    cout << "\t\t; Para todos los libros que se quieren leer, asignados. Para los paralelos a los asignados, ya leidos o asignados\n";
    cout << "\t\t(and (forall (?l - quiereL) (asignado ?l))\n";
    cout << "\t\t\t (forall (?l - libro ?par - libro) (imply (and (asignado ?l) (paralelo ?l ?par)) (or (asignado ?par) (leido ?par))))\n";

    cout << "\t\t)\n"; //cierra and

    cout << "\t)\n"; //cierra goal

    cout << ")\n"; //cierra fichero

    //printPreDOT();
    //printParDOT();
    printDOT();
}