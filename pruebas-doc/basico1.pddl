; DEBUG: DAG con 20 libros:
; prerequisitos on
; paralelos off
; npaginas off
; Fichero generado con el programa, seed 42
(define (problem Libros-base)
	(:domain Lectura)
	(:objects
		Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre - mes
		Libro0 Libro1 Libro2 Libro3 Libro4 Libro5 Libro6 Libro7 Libro8 Libro9 Libro10 Libro11 Libro12 Libro13 Libro14 Libro15 Libro16 Libro17 Libro18 Libro19 - libro
	)

	(:init
		; Datos universales
		(anterior Enero Febrero) (anterior Enero Marzo) (anterior Enero Abril) (anterior Enero Mayo) (anterior Enero Junio) (anterior Enero Julio) (anterior Enero Agosto) (anterior Enero Septiembre) (anterior Enero Octubre) (anterior Enero Noviembre) (anterior Enero Diciembre) (anterior Febrero Marzo) (anterior Febrero Abril) (anterior Febrero Mayo) (anterior Febrero Junio) (anterior Febrero Julio) (anterior Febrero Agosto) (anterior Febrero Septiembre) (anterior Febrero Octubre) (anterior Febrero Noviembre) (anterior Febrero Diciembre) (anterior Marzo Abril) (anterior Marzo Mayo) (anterior Marzo Junio) (anterior Marzo Julio) (anterior Marzo Agosto) (anterior Marzo Septiembre) (anterior Marzo Octubre) (anterior Marzo Noviembre) (anterior Marzo Diciembre) (anterior Abril Mayo) (anterior Abril Junio) (anterior Abril Julio) (anterior Abril Agosto) (anterior Abril Septiembre) (anterior Abril Octubre) (anterior Abril Noviembre) (anterior Abril Diciembre) (anterior Mayo Junio) (anterior Mayo Julio) (anterior Mayo Agosto) (anterior Mayo Septiembre) (anterior Mayo Octubre) (anterior Mayo Noviembre) (anterior Mayo Diciembre) (anterior Junio Julio) (anterior Junio Agosto) (anterior Junio Septiembre) (anterior Junio Octubre) (anterior Junio Noviembre) (anterior Junio Diciembre) (anterior Julio Agosto) (anterior Julio Septiembre) (anterior Julio Octubre) (anterior Julio Noviembre) (anterior Julio Diciembre) (anterior Agosto Septiembre) (anterior Agosto Octubre) (anterior Agosto Noviembre) (anterior Agosto Diciembre) (anterior Septiembre Octubre) (anterior Septiembre Noviembre) (anterior Septiembre Diciembre) (anterior Octubre Noviembre) (anterior Octubre Diciembre) (anterior Noviembre Diciembre) 
		; Relaciones entre objetos
		(leido Libro12)
		(leido Libro13)
		(quiere_leer Libro0)
		(quiere_leer Libro1)
		(quiere_leer Libro2)
		(quiere_leer Libro3)
		(quiere_leer Libro5)
		(quiere_leer Libro6)
		(quiere_leer Libro7)
		(quiere_leer Libro8)
		(quiere_leer Libro9)
		(quiere_leer Libro10)
		(quiere_leer Libro11)
		(quiere_leer Libro14)
		(quiere_leer Libro16)
		(quiere_leer Libro17)
		(quiere_leer Libro18)
		(predecesor Libro1 Libro3)
		(predecesor Libro2 Libro9)
		(predecesor Libro4 Libro16)
		(predecesor Libro5 Libro10)
		(predecesor Libro6 Libro8)
		(predecesor Libro7 Libro11)
		(predecesor Libro13 Libro15)
	)

	(:goal
		; Para todos los libros que se quieren leer, asignados.
		(forall (?l - libro) (imply (quiere_leer ?l) (asignado ?l)))
	)
)
