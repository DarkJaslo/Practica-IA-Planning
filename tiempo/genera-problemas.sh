# Genera los juegos de prueba para el experimento del tiempo

if [ $# -ne 3 ]; then
    echo "Hay que dar tres seeds:"
    echo ./genera-problemas.sh seed1 seed2 seed3
    exit
fi

cd ..
make
cd tiempo
counter=5
step=5
limite=60
seed1=$1
seed2=$2
seed3=$3


if [ ! -d "juegos" ]; then
    mkdir "juegos"
fi

if [ ! -d "grafos-ext2" ]; then
    mkdir "grafos-ext2"
fi

while [ $counter -le $limite ]
do
    ../pruebas $counter $seed1 "ext2" > ./juegos/prueba$counter-$seed1.pddl
    ../pruebas $counter $seed2 "ext2" > ./juegos/prueba$counter-$seed2.pddl
    ../pruebas $counter $seed3 "ext2" > ./juegos/prueba$counter-$seed3.pddl
    ((counter+=step))
    ((seed1+=step))
    ((seed2+=step))
    ((seed3+=step))
done