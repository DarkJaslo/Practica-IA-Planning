# Genera los pngs de cada grafo de los juegos de prueba. Usa dot, que requiere instalar graphviz

counter=3
step=3
limite=30
cd grafos-basico
while [ $counter -le $limite ]
do
    dot -Tpng "grafo$counter.dot" -o "grafo$counter.png"
    ((counter+=step))
done
cd ..

counter=3
step=3
limite=30
cd grafos-ext1
while [ $counter -le $limite ]
do
    dot -Tpng "grafo$counter.dot" -o "grafo$counter.png"
    ((counter+=step))
done
cd ..

counter=3
step=3
limite=30
cd grafos-ext2
while [ $counter -le $limite ]
do
    dot -Tpng "grafo$counter.dot" -o "grafo$counter.png"
    ((counter+=step))
done
cd ..

counter=3
step=3
limite=30
cd grafos-ext3
while [ $counter -le $limite ]
do
    dot -Tpng "grafo$counter.dot" -o "grafo$counter.png"
    ((counter+=step))
done
cd ..