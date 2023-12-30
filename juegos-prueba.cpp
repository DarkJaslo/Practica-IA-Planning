/*
    Programa para generar juegos de prueba aleatorios del planner, by Jon Campillo
*/

#include <iostream>
#include <vector>
using namespace std;

const vector<string> MESES = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
bool PRE_ON;
bool PAR_ON;
bool PAG_ON;


void printObjetos()
{

}

void printUniversalFacts()
{
    for(int i = 0; i < MESES.size()-1; ++i)
    {
        cout << "\t\t(inm_anterior " << MESES[i] << " " << MESES[i+1] << ")\n";
    }

	for(int i = 0; i < MESES.size(); ++i)
	{
        for(int j = i+1; j < MESES.size(); ++j)
        {
            cout << "\t\t(anterior " << MESES[i] << " " << MESES[j] << ")\n";
        }
	}
}

void printRelaciones()
{

}

void usage()
{
    cout << "Usage: ./juegos-prueba [prerequisitos] [paralelos] [paginas]\nDonde se pone \"on\" u \"off\" en cada campo, en funcion de si se quiere activar o no.\n";
}

int main(int argc, char** argv)
{
    if(argc != 4)
    {
        usage();
    }

    string pre = string(argv[1]);
    string par = string(argv[2]);
    string pag = string(argv[3]);

    PRE_ON = pre=="on";
    PAR_ON = par=="on";
    PAG_ON = pag=="on";

    cout << "(define (problem Libros-base)\n";
    cout << "\t(:domain Libros)\n";
    cout << "\t(:objects\n";
    //meses
    cout << "\t\t"; 
    for(const string& mes : MESES)
        cout << mes << " ";
    cout << "- mes\n";
    //fin meses

    //objetos a continuacion
    cout << "\t\t";
    printObjetos();
    cout << "\n";    //fin objetos
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
    cout << "\t\t\t (forall (?l - libro) (imply (exists (?par - quiereL) (paralelo ?par ?l)) (asignado ?l)))\n";

    cout << "\t\t)\n"; //cierra and

    cout << "\t)\n"; //cierra goal

    cout << ")\n"; //cierra fichero
}