# Ejecuta los juegos de prueba, tienes que dar el nivel de extensiones a probar

if [ $# -ne 1 ]; then
    echo "Hay que dar un argumento:"
    echo "basico    -   sin extensiones"
    echo "ext1      -   extension 1"
    echo "ext2      -   extension 2"
    echo "ext3      -   extension 3"
    exit
fi

# Check de los argumentos
if [ "$1" = "basico" ]; then
    :
elif [ "$1" = "ext1" ]; then
    :
elif [ "$1" = "ext2" ]; then
    :
elif [ "$1" = "ext3" ]; then
    :
else
    echo "El argumento dado, \"$1\", no esta en las opciones"
    exit
fi

counter=3
step=3
limite=30
secs=75
while [ $counter -le $limite ]
do
    echo "---------------------------------------------------------"
    echo "ejecutando prueba $counter"
    echo "---------------------------------------------------------"
    timeout $secs ff -O -o domain-$1.pddl -f ./juegos-$1/prueba$counter.pddl

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

    ((counter+=step))
done