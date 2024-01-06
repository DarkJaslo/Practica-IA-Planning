# Ejecuta los juegos de prueba

counter=10
secs=15
while [ $counter -le 40 ]
do
    echo "---------------------------------------------------------"
    echo "ejecutando prueba $counter"
    echo "---------------------------------------------------------"
    timeout $secs ff -O -o domain.pddl -f ./juegos-prueba/prueba$counter.pddl

    if [ $? -eq 0 ]; then
        # Ha acabado a tiempo
        echo "---------------------------------------------------------"
        echo "prueba completada a tiempo"
        echo "---------------------------------------------------------"
    else
        echo "---------------------------------------------------------"
        echo "la prueba no ha acabado en $secs segundos"
        echo "---------------------------------------------------------"
    fi

    ((counter++))
done