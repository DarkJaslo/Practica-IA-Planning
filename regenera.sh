# Genera los juegos de prueba

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

make
counter=3
step=3
limite=30

if [ ! -d "juegos-$1" ]; then
    mkdir "juegos-$1"
fi

if [ ! -d "grafos-$1" ]; then
    mkdir "grafos-$1"
fi

while [ $counter -le $limite ]
do
    ./pruebas $counter $counter $1 > ./juegos-$1/prueba$counter.pddl
    ((counter+=step))
done