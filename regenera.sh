# Genera los juegos de prueba

make
counter=10
while [ $counter -le 40 ]
do
    ./pruebas $counter on on on > prueba$counter.pddl
    ((counter++))
done