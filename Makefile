pruebas: juegos-prueba.cpp
	g++ -O3 -Wall -Wno-sign-compare -D_GLIBCXX_DEBUG -o pruebas juegos-prueba.cpp

clean:
	rm pruebas