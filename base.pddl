; Fichero de problema base

;Header and description

(define (problem Libros-base)
    (:domain Libros)
    (:objects 
        Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre - mes
    )

    (:init
        ; Informacion universal



        ; Poner libros leidos como leidoL

        ; Poner libros que se quieren leer como quiereL

        ; Poner el resto de libros aqui


        ; Predicados sobre predecesores y paralelos aqui
    )

    (:goal 
        ; Para todos los libros que se quieren leer, leidos
        (forall (?l - quiereL) (asignado ?l))
    )

)