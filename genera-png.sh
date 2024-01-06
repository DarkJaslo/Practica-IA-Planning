# Genera los pngs de cada grafo de los juegos de prueba. Usa dot, que requiere instalar graphviz

counter=10
cd grafos

while [ $counter -le 40 ]
do
    dot -Tpng "grafo$counter.dot" -o "grafo$counter.png"
    ((counter++))
done

cd ..