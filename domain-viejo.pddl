; Dominio de la practica de planificacion de IA.
; Recomendaciones VSCode: descargar extension PDDL 

(define (domain Lectura)
    (:requirements :adl :typing :fluents)

    (:types
      libro mes - object
      quiereL otrosL - libro
    )

    (:predicates
      (predecesor ?pre - libro ?post - libro)
      (paralelo ?l1 - libro ?l2 - libro)
      (asignado ?l - libro)
      (leyendo ?l - libro ?m - mes)
      (anterior ?ant - mes ?post - mes)
      (inm_anterior ?ant - mes ?post - mes)
      (leido ?l - libro)
    )

    ; Valores numericos (fluentes)
    (:functions
      (paginas-leidas ?mes - mes)
      (paginas ?l - libro)
    )

  (:action leer
    :parameters (?l - libro ?mact - mes ?mant - mes)
    :precondition (and (not (asignado ?l))
                        (not (leido ?l))
                        (inm_anterior ?mant ?mact)
                  ; Verifica numero de paginas mensuales
                    (<= (+ (paginas-leidas ?mact) (paginas ?l)) 800)

                  ; Verifica que todos los prerequisitos se han asignado a meses previos al actual
                  (forall (?pre - libro) (imply (predecesor ?pre ?l) (or (leido ?pre) (exists (?mpre - mes) (and (leyendo ?pre ?mpre) (anterior ?mpre ?mact)) ))))

                  ; Para todos los libros paralelos, si estan asignados, es en el mes anterior (mant) o en el actual (mact)
                  (forall (?par - libro) (imply (and (paralelo ?par ?l) (asignado ?par)) (or (leyendo ?par ?mact) (leyendo ?par ?mant)  )))
                  
                  )
    :effect (and (asignado ?l)
                  (leyendo ?l ?mact)
                  (increase (paginas-leidas ?mact) (paginas ?l))
            )
  )  
)