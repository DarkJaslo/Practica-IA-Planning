; DEBUG: DAG con 40 libros:
; prerequisitos on
; paralelos off
; npaginas off
; Fichero generado con el programa, seed 92
(define (problem Libros-base)
	(:domain Lectura)
	(:objects
		Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre - mes
		Libro0 Libro1 Libro2 Libro3 Libro4 Libro5 Libro6 Libro7 Libro8 Libro9 Libro10 Libro11 Libro12 Libro13 Libro14 Libro15 Libro16 Libro17 Libro18 Libro19 Libro20 Libro21 Libro22 Libro23 Libro24 Libro25 Libro26 Libro27 Libro28 Libro29 Libro30 Libro31 Libro32 Libro33 Libro34 Libro35 Libro36 Libro37 Libro38 Libro39 - libro
	)

	(:init
		; Datos universales
		(anterior Enero Febrero) (anterior Enero Marzo) (anterior Enero Abril) (anterior Enero Mayo) (anterior Enero Junio) (anterior Enero Julio) (anterior Enero Agosto) (anterior Enero Septiembre) (anterior Enero Octubre) (anterior Enero Noviembre) (anterior Enero Diciembre) (anterior Febrero Marzo) (anterior Febrero Abril) (anterior Febrero Mayo) (anterior Febrero Junio) (anterior Febrero Julio) (anterior Febrero Agosto) (anterior Febrero Septiembre) (anterior Febrero Octubre) (anterior Febrero Noviembre) (anterior Febrero Diciembre) (anterior Marzo Abril) (anterior Marzo Mayo) (anterior Marzo Junio) (anterior Marzo Julio) (anterior Marzo Agosto) (anterior Marzo Septiembre) (anterior Marzo Octubre) (anterior Marzo Noviembre) (anterior Marzo Diciembre) (anterior Abril Mayo) (anterior Abril Junio) (anterior Abril Julio) (anterior Abril Agosto) (anterior Abril Septiembre) (anterior Abril Octubre) (anterior Abril Noviembre) (anterior Abril Diciembre) (anterior Mayo Junio) (anterior Mayo Julio) (anterior Mayo Agosto) (anterior Mayo Septiembre) (anterior Mayo Octubre) (anterior Mayo Noviembre) (anterior Mayo Diciembre) (anterior Junio Julio) (anterior Junio Agosto) (anterior Junio Septiembre) (anterior Junio Octubre) (anterior Junio Noviembre) (anterior Junio Diciembre) (anterior Julio Agosto) (anterior Julio Septiembre) (anterior Julio Octubre) (anterior Julio Noviembre) (anterior Julio Diciembre) (anterior Agosto Septiembre) (anterior Agosto Octubre) (anterior Agosto Noviembre) (anterior Agosto Diciembre) (anterior Septiembre Octubre) (anterior Septiembre Noviembre) (anterior Septiembre Diciembre) (anterior Octubre Noviembre) (anterior Octubre Diciembre) (anterior Noviembre Diciembre) 
		; Relaciones entre objetos
		(leido Libro10)
		(leido Libro22)
		(quiere_leer Libro0)
		(quiere_leer Libro1)
		(quiere_leer Libro2)
		(quiere_leer Libro3)
		(quiere_leer Libro4)
		(quiere_leer Libro5)
		(quiere_leer Libro6)
		(quiere_leer Libro7)
		(quiere_leer Libro9)
		(quiere_leer Libro12)
		(quiere_leer Libro13)
		(quiere_leer Libro14)
		(quiere_leer Libro16)
		(quiere_leer Libro17)
		(quiere_leer Libro18)
		(quiere_leer Libro19)
		(quiere_leer Libro20)
		(quiere_leer Libro21)
		(quiere_leer Libro24)
		(quiere_leer Libro25)
		(quiere_leer Libro26)
		(quiere_leer Libro27)
		(quiere_leer Libro28)
		(quiere_leer Libro29)
		(quiere_leer Libro31)
		(quiere_leer Libro32)
		(quiere_leer Libro35)
		(quiere_leer Libro36)
		(quiere_leer Libro37)
		(quiere_leer Libro38)
		(quiere_leer Libro39)
		(predecesor Libro0 Libro8)
		(predecesor Libro1 Libro23)
		(predecesor Libro2 Libro19)
		(predecesor Libro3 Libro4)
		(predecesor Libro5 Libro17)
		(predecesor Libro6 Libro7)
		(predecesor Libro9 Libro30)
		(predecesor Libro10 Libro32)
		(predecesor Libro11 Libro18)
		(predecesor Libro12 Libro20)
		(predecesor Libro13 Libro29)
		(predecesor Libro16 Libro38)
		(predecesor Libro21 Libro31)
		(predecesor Libro22 Libro27)
		(predecesor Libro24 Libro28)
		(predecesor Libro25 Libro37)
		(predecesor Libro35 Libro39)
	)

	(:goal
		; Para todos los libros que se quieren leer, asignados.
		(forall (?l - libro) (imply (quiere_leer ?l) (asignado ?l)))
	)
)
