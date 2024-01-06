; Fichero de problema base

(define (problem Libros-base)
    (:domain Lectura)
    (:objects 
        Enero Febrero Marzo - mes
        Libro3 Par3 - quiereL
        Libro1 Libro2 Par1 Par2 - otrosL
    )

    (:init
        ; Informacion universal
        (inm_anterior Enero Febrero)
        (inm_anterior Febrero Marzo)
        (anterior Enero Febrero)
        (anterior Enero Marzo)
        (anterior Febrero Marzo)

        (leido Par2)
        (predecesor Libro1 Libro2)
        (predecesor Libro2 Libro3)
        (paralelo Par3 Par1)
        (paralelo Par1 Par3)
        (paralelo Par3 Par2)
        (paralelo Par2 Par3)
        (paralelo Par1 Par2)
        (paralelo Par2 Par1)
        (= (paginas Libro1) 400)
        (= (paginas Libro2) 400)
        (= (paginas Libro3) 400)
        (= (paginas Par1) 400)
        (= (paginas Par2) 400)
        (= (paginas Par3) 400)

        (= (paginas-leidas Enero) 0)
        (= (paginas-leidas Febrero) 0)
        (= (paginas-leidas Marzo) 0)
    )

    (:goal 
        ; Para todos los libros que se quieren leer, asignados. Para los paralelos a los asignados, ya leidos o asignados
        (and (forall (?l - quiereL) (asignado ?l))
            (forall (?l - libro ?par - libro) (imply (and (asignado ?l) (paralelo ?l ?par)) (or (asignado ?par) (leido ?par))))
        )
    )

)