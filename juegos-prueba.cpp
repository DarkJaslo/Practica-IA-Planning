/*
    Programa para generar juegos de prueba aleatorios del planner, by Jon Campillo
*/

#include <iostream>
#include <vector>
using namespace std;

const vector<string> MESES = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};

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

int main()
{
    cout << "(define (problem Libros-base)\n";
    cout << "\t(:domain Libros)\n";
    cout << "\t(:objects\n";
    cout << "\t\t"; 
    //objetos a continuacion
    cout << "\n";    //fin objetos
    cout << "\t)\n"; //cierra parentesis objetos
    cout << "\n";    //linea en blanco

    cout << "\t(:init\n";

    cout << "\t\t; Datos universales\n";
	printUniversalFacts();
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