# Genera los juegos de prueba

make
counter=10

if [ ! -d "juegos-prueba" ]; then
    mkdir "juegos-prueba"
fi

if [ ! -d "grafos" ]; then
    mkdir "grafos"
fi

while [ $counter -le 40 ]
do
    ./pruebas $counter on on off $counter > ./juegos-prueba/prueba$counter.pddl
    ((counter++))
done