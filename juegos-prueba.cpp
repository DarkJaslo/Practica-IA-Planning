/*
    Programa para generar juegos de prueba aleatorios del planner, by Jon Campillo
*/

#include <iostream>
#include <vector>
#include <random>
using namespace std;

const vector<string> MESES = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
bool PRE_ON;
bool PAR_ON;
bool PAG_ON;
int N;
vector<pair<int,int>> PRES;
vector<pair<int,int>> PARS;
vector<int> PAGS;
vector<vector<bool>> DAG;
vector<vector<bool>> reach; //Matriz que indica si dos nodos estan conectados por algun camino
int PROB_PRE = 3;   //Sobre 100, se mira entre cada par ordenado
int PROB_PAR = 3;   //Sobre 100, se mira entre cada par no accesible mutuamente
int PROB_LEER = 80; //Sobre 100, se mira para cada libro
int PROB_LEIDO = 10; //Sobre 100, se mira para cada libro
//int SEED = 1234;
long SEED = time(NULL);
mt19937 gen;
uniform_int_distribution<int> distr;
vector<bool> QUIERE_LEER;
vector<bool> LEIDO;

bool rollRandom(int prob)
{
    int randomN = distr(gen);
    return randomN < prob;
}

void BFS(int nodo, vector<vector<bool>>& DAG, vector<vector<bool>>& reach)
{
    for(int i = nodo+1; i < N; ++i)
    {
        if(DAG[nodo][i])
        {
            reach[nodo][i] = true;

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

    //Crea dependencias
    if(PRE_ON)
    {
        for(int i = 0; i < N; ++i)
        {
            for(int j = i+1; j < N; ++j)
            {            
                if(rollRandom(PROB_PRE))
                {
                    DAG[i][j] = true;
                    PRES.push_back(make_pair(i,j));
                }  
            }
        }
    }

    reach = vector<vector<bool>>(N, vector<bool>(N,false));

    //Entre libros sin dependencias entre medio, pon paralelos
    if(PAR_ON)
    {
        for(int i = 0; i < N; ++i)
        {
            BFS(i,DAG,reach);
        }

        //Para los que no esten conectados, se puede poner paralelo
        for(int i = 0; i < N; ++i)
        {
            for(int j = i+1; j < N; ++j)
            {
                if(not reach[i][j] and rollRandom(PROB_PAR))
                {
                    PARS.push_back(make_pair(i,j));
                    PARS.push_back(make_pair(j,i));
                }
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
    }

    for(int i = 0; i < N; ++i)
    {
        cout << "\t\t(= (paginas Libro" << i << ") " << PAGS[i] << ")\n";
    }
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

    cerr << "DEBUG: DAG con " << N << " libros:\n";
    cerr << "prerequisitos "; PRE_ON ? cerr << "on" : cerr << "off"; cerr << "\n";
    cerr << "paralelos "; PAR_ON ? cerr << "on" : cerr << "off"; cerr << "\n";
    cerr << "npaginas "; PAG_ON ? cerr << "on" : cerr << "off"; cerr << "\n";

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
    cout << "\t\t; Para todos los libros que se quieren leer, leidos. Para los paralelos a los que se quieren leer, leidos\n";
    cout << "\t\t(and (forall (?l - quiereL) (asignado ?l))\n";
    cout << "\t\t\t (forall (?l - libro) (imply (exists (?par - quiereL) (paralelo ?par ?l)) (or (leido ?l) (asignado ?l))))\n";

    cout << "\t\t)\n"; //cierra and

    cout << "\t)\n"; //cierra goal

    cout << ")\n"; //cierra fichero
}