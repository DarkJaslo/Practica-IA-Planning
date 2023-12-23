; Dominio de la practica de planificacion de IA.
; Recomendaciones VSCode: descargar extension PDDL 

(define (domain Lectura)
    (:requirements :adl :typing)

    (:types
        libro - object
    )

    (:predicates
        (predecesor ?pre - libro ?post - libro)
        (paralelo ?l1 - libro ?l2 - libro)
        (leido ?l - libro)
        (quiere-leer ?l - libro)

    )

    ; Ejemplo de accion
    (:action action_name
        :parameters ()
        :precondition (and )
        :effect (and )
    )
)