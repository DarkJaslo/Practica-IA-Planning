; Dominio de la practica de planificacion de IA.
; Version extension 3 (Prerrequisitos, paralelos, numero de paginas)
; Recomendaciones VSCode: descargar extension PDDL 

(define (domain Lectura)
    (:requirements :adl :typing :fluents)

    (:types
      libro mes - object
    )

    (:predicates
      (predecesor ?pre - libro ?post - libro)
      (paralelo ?l1 - libro ?l2 - libro)
      (asignado ?l - libro)
      (leyendo ?l - libro ?m - mes)
      (anterior ?ant - mes ?post - mes)
      (inm_anterior ?ant - mes ?post - mes)
      (leido ?l - libro)
      (quiere_leer ?l - libro)
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
                        ;(quiere_leer ?l)
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
                  ; Obliga a leer todos los paralelos (que no se hayan leido ya)
                  (forall (?par - libro) (when (and (paralelo ?par ?l) (not (or (leido ?par) (asignado ?par)))) (quiere_leer ?par)))
            )
  )  
)