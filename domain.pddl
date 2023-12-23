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
    :parameters (?l - libro ?m - mes ?mant - mes)
    :precondition (and (not (asignado ?l))
                        (inm_anterior ?mant ?m)
                        (not (leido ?l))
                  ; Verifica numero de paginas mensuales
                    (<= (+ (paginas-leidas ?m) (paginas ?l)) 800)

                  ; Verifica que todos los prerequisitos se han asignado
                  (forall (?pre - libro 
                           ?mpre - mes) 
                                (imply 
                                      (and (predecesor ?pre ?l) (anterior ?mpre ?m))    
                                      (leyendo ?pre ?mpre) 
                                )
                  )
                  ; Verifica que si hay paralelos, se lean a la vez o el mes inmediatamente anterior
                  (forall (?par - libro) (imply (paralelo ?par ?l) 
                                                  (or (leyendo ?par ?m)
                                                      (leyendo ?par ?mant))
                                          )
                  )
                  )
    :effect (and (asignado ?l)
                  (leyendo ?l ?m)
                  (increase (paginas-leidas ?m) (paginas ?l))
              )
  )
)