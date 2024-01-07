; Dominio de la practica de planificacion de IA.
; Version extension 2 (Prerrequisitos, paralelos)
; Recomendaciones VSCode: descargar extension PDDL 

(define (domain Lectura)
    (:requirements :adl :typing)

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

  (:action leer
    :parameters (?l - libro ?mact - mes ?mant - mes)
    :precondition (and
                    (not (asignado ?l))
                    (not (leido ?l))
                    (inm_anterior ?mant ?mact)

                    ; Verifica que todos los prerequisitos se han asignado a meses previos al actual
                    (forall (?pre - libro) (imply (predecesor ?pre ?l) 
                      (or (leido ?pre) (exists (?mpre - mes) (and (leyendo ?pre ?mpre) (anterior ?mpre ?mact)) ))))

                    ; Para todos los libros paralelos, si estan asignados, es en el mes anterior (mant) o en el actual (mact)
                    (forall (?par - libro) (imply (and (paralelo ?par ?l) (asignado ?par)) 
                      (or (leyendo ?par ?mact) (leyendo ?par ?mant) )))
                  )
    :effect (and  (asignado ?l)
                  (leyendo ?l ?mact)
                  ; Obliga a leer todos los paralelos (que no se hayan leido o hayan sido asignados ya)
                  (forall (?par - libro) (when (and (paralelo ?par ?l) (not (or (leido ?par) (asignado ?par)))) 
                    (quiere_leer ?par)))
            )
  )  
)