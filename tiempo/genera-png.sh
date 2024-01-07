# Genera los pngs de cada grafo de los juegos de prueba. Usa dot, que requiere instalar graphviz

seed1=$1
seed2=$2
seed3=$3

counter=5
step=5
limite=60
cd grafos-ext2
while [ $counter -le $limite ]
do
    dot -Tpng "grafo$counter-$seed1.dot" -o "grafo$counter-$seed1.png"
    dot -Tpng "grafo$counter-$seed2.dot" -o "grafo$counter-$seed2.png"
    dot -Tpng "grafo$counter-$seed3.dot" -o "grafo$counter-$seed3.png"
    ((counter+=step))
    ((seed1+=step))
    ((seed2+=step))
    ((seed3+=step))
done
cd ..