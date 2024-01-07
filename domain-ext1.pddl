; Dominio de la practica de planificacion de IA.
; Version extension 1 (Prerrequisitos)
; Recomendaciones VSCode: descargar extension PDDL 

(define (domain Lectura)
    (:requirements :adl :typing)

    (:types
      libro mes - object
    )

    (:predicates
      (predecesor ?pre - libro ?post - libro)
      (asignado ?l - libro)
      (leyendo ?l - libro ?m - mes)
      (anterior ?ant - mes ?post - mes)
      (leido ?l - libro)
      (quiere_leer ?l - libro)
    )

  (:action leer
    :parameters (?l - libro ?mact - mes)
    :precondition (and
                    (not (asignado ?l))
                    (not (leido ?l))

                    ; Verifica que todos los prerequisitos se han asignado a meses previos al actual
                    (forall (?pre - libro) (imply (predecesor ?pre ?l) 
                      (or (leido ?pre) (exists (?mpre - mes) (and (leyendo ?pre ?mpre) (anterior ?mpre ?mact)) ))))
                  )
    :effect (and (asignado ?l) (leyendo ?l ?mact))
  )  
)