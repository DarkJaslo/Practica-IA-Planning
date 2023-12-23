; Dominio de la practica de planificacion de IA.
; Recomendaciones VSCode: descargar extension PDDL 

(define (domain Lectura)
    (:requirements :adl :typing :fluents)

    (:types
      libro mes - object
      quiereL leidoL otrosL - libro
    )

    (:predicates
      (predecesor ?pre - libro ?post - libro)
      (paralelo ?l1 - libro ?l2 - libro)
      (asignado ?l - libro)
      (leyendo ?l - libro ?m - mes)
      (anterior ?ant - mes ?post - mes)
      (inm_anterior ?ant - mes ?post - mes)
    )

    ; Valores numericos (fluentes)
    (:functions
      (paginas ?mes - mes)
      (anterioridad ?ant - mes ?post - mes) ; numero de meses entre dos meses
    )

    ; Ejemplo de accion
    (:action action_name
        :parameters ()
        :precondition (and )
        :effect (and )
    )

  (:action leer
    :parameters (?l - libro ?m - mes ?mant - mes)
    :precondition (and (not (asignado ?l))
                        (inm_anterior ?mant ?m)
                  (forall (?pre - libro 
                           ?mpre - mes) 
                                (imply 
                                      (and (predecesor ?pre ?l) (anterior ?mpre ?m))    
                                      (leyendo ?pre ?mpre) 
                                )
                  )
                  (forall (?par - libro) (imply (paralelo ?par ?l) 
                                                  (or (leyendo ?par ?m)
                                                      (leyendo ?par ?mant))
                                          )
                  )
                  )
    :effect (and )
  )
)