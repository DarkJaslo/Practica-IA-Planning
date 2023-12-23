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
    :parameters (?l - libro ?m - mes)
    :precondition (and (not (asignado ?l))
                        (not (leido ?l))
                  ; Verifica numero de paginas mensuales
                    (<= (+ (paginas-leidas ?m) (paginas ?l)) 800)

                  ; Verifica que todos los prerequisitos se han asignado
                  (forall (?pre - libro) (imply (predecesor ?pre ?l) (or (leido ?pre) (exists (?mpre - mes) (and (leyendo ?pre ?mpre) (anterior ?mpre ?m)) ))))

                  ; Para todos los libros paralelos, si estan asignados, es hace 1 mes o ahora
                  (forall (?par - libro) (imply (and (paralelo ?par ?l) (asignado ?par)) (or (leyendo ?par ?m) (exists (?mant - mes) (and (inm_anterior ?mant ?m) (leyendo ?par ?mant)) ) )))
                  
                  )
    :effect (and (asignado ?l)
                  (leyendo ?l ?m)
                  (increase (paginas-leidas ?m) (paginas ?l))
              )
  )  
)