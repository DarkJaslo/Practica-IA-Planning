; Fichero de problema base

;Header and description

(define (problem Libros-base)
    (:domain Libros)
    (:objects 
        Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre - mes
    )

    (:init
        ; Informacion universal
        (inm_anterior Enero Febrero)
        (inm_anterior Febrero Marzo)
        (inm_anterior Marzo Abril)
        (inm_anterior Abril Mayo)
        (inm_anterior Mayo Junio)
        (inm_anterior Junio Julio)
        (inm_anterior Julio Agosto)
        (inm_anterior Agosto Septiembre)
        (inm_anterior Septiembre Octubre)
        (inm_anterior Octubre Noviembre)
        (inm_anterior Noviembre Diciembre)
        (anterior Enero Febrero)
        (anterior Enero Marzo)
        (anterior Enero Abril)
        (anterior Enero Mayo)
        (anterior Enero Junio)
        (anterior Enero Julio)
        (anterior Enero Agosto)
        (anterior Enero Septiembre)
        (anterior Enero Octubre)
        (anterior Enero Noviembre)
        (anterior Enero Diciembre)
        (anterior Febrero Marzo)
        (anterior Febrero Abril)
        (anterior Febrero Mayo)
        (anterior Febrero Junio)
        (anterior Febrero Julio)
        (anterior Febrero Agosto)
        (anterior Febrero Septiembre)
        (anterior Febrero Octubre)
        (anterior Febrero Noviembre)
        (anterior Febrero Diciembre)
        (anterior Marzo Abril)
        (anterior Marzo Mayo)
        (anterior Marzo Junio)
        (anterior Marzo Julio)
        (anterior Marzo Agosto)
        (anterior Marzo Septiembre)
        (anterior Marzo Octubre)
        (anterior Marzo Noviembre)
        (anterior Marzo Diciembre)
        (anterior Abril Mayo)
        (anterior Abril Junio)
        (anterior Abril Julio)
        (anterior Abril Agosto)
        (anterior Abril Septiembre)
        (anterior Abril Octubre)
        (anterior Abril Noviembre)
        (anterior Abril Diciembre)
        (anterior Mayo Junio)
        (anterior Mayo Julio)
        (anterior Mayo Agosto)
        (anterior Mayo Septiembre)
        (anterior Mayo Octubre)
        (anterior Mayo Noviembre)
        (anterior Mayo Diciembre)
        (anterior Junio Julio)
        (anterior Junio Agosto)
        (anterior Junio Septiembre)
        (anterior Junio Octubre)
        (anterior Junio Noviembre)
        (anterior Junio Diciembre)
        (anterior Julio Agosto)
        (anterior Julio Septiembre)
        (anterior Julio Octubre)
        (anterior Julio Noviembre)
        (anterior Julio Diciembre)
        (anterior Agosto Septiembre)
        (anterior Agosto Octubre)
        (anterior Agosto Noviembre)
        (anterior Agosto Diciembre)
        (anterior Septiembre Octubre)
        (anterior Septiembre Noviembre)
        (anterior Septiembre Diciembre)
        (anterior Octubre Noviembre)
        (anterior Octubre Diciembre)
        (anterior Noviembre Diciembre)




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