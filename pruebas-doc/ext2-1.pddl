; DEBUG: DAG con 26 libros:
; prerequisitos on
; paralelos on
; npaginas off
; Fichero generado con el programa, seed 9
(define (problem Libros-base)
	(:domain Lectura)
	(:objects
		Casper Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre - mes
		Libro0 Libro1 Libro2 Libro3 Libro4 Libro5 Libro6 Libro7 Libro8 Libro9 Libro10 Libro11 Libro12 Libro13 Libro14 Libro15 Libro16 Libro17 Libro18 Libro19 Libro20 Libro21 Libro22 Libro23 Libro24 Libro25 - libro
	)

	(:init
		; Datos universales
		(inm_anterior Casper Enero) (inm_anterior Enero Febrero) (inm_anterior Febrero Marzo) (inm_anterior Marzo Abril) (inm_anterior Abril Mayo) (inm_anterior Mayo Junio) (inm_anterior Junio Julio) (inm_anterior Julio Agosto) (inm_anterior Agosto Septiembre) (inm_anterior Septiembre Octubre) (inm_anterior Octubre Noviembre) (inm_anterior Noviembre Diciembre) 
		(anterior Enero Febrero) (anterior Enero Marzo) (anterior Enero Abril) (anterior Enero Mayo) (anterior Enero Junio) (anterior Enero Julio) (anterior Enero Agosto) (anterior Enero Septiembre) (anterior Enero Octubre) (anterior Enero Noviembre) (anterior Enero Diciembre) (anterior Febrero Marzo) (anterior Febrero Abril) (anterior Febrero Mayo) (anterior Febrero Junio) (anterior Febrero Julio) (anterior Febrero Agosto) (anterior Febrero Septiembre) (anterior Febrero Octubre) (anterior Febrero Noviembre) (anterior Febrero Diciembre) (anterior Marzo Abril) (anterior Marzo Mayo) (anterior Marzo Junio) (anterior Marzo Julio) (anterior Marzo Agosto) (anterior Marzo Septiembre) (anterior Marzo Octubre) (anterior Marzo Noviembre) (anterior Marzo Diciembre) (anterior Abril Mayo) (anterior Abril Junio) (anterior Abril Julio) (anterior Abril Agosto) (anterior Abril Septiembre) (anterior Abril Octubre) (anterior Abril Noviembre) (anterior Abril Diciembre) (anterior Mayo Junio) (anterior Mayo Julio) (anterior Mayo Agosto) (anterior Mayo Septiembre) (anterior Mayo Octubre) (anterior Mayo Noviembre) (anterior Mayo Diciembre) (anterior Junio Julio) (anterior Junio Agosto) (anterior Junio Septiembre) (anterior Junio Octubre) (anterior Junio Noviembre) (anterior Junio Diciembre) (anterior Julio Agosto) (anterior Julio Septiembre) (anterior Julio Octubre) (anterior Julio Noviembre) (anterior Julio Diciembre) (anterior Agosto Septiembre) (anterior Agosto Octubre) (anterior Agosto Noviembre) (anterior Agosto Diciembre) (anterior Septiembre Octubre) (anterior Septiembre Noviembre) (anterior Septiembre Diciembre) (anterior Octubre Noviembre) (anterior Octubre Diciembre) (anterior Noviembre Diciembre) 
		; Relaciones entre objetos
		(leido Libro25)
		(quiere_leer Libro0)
		(quiere_leer Libro1)
		(quiere_leer Libro2)
		(quiere_leer Libro3)
		(quiere_leer Libro4)
		(quiere_leer Libro5)
		(quiere_leer Libro6)
		(quiere_leer Libro8)
		(quiere_leer Libro9)
		(quiere_leer Libro10)
		(quiere_leer Libro11)
		(quiere_leer Libro12)
		(quiere_leer Libro14)
		(quiere_leer Libro15)
		(quiere_leer Libro16)
		(quiere_leer Libro17)
		(quiere_leer Libro19)
		(quiere_leer Libro20)
		(quiere_leer Libro21)
		(quiere_leer Libro23)
		(quiere_leer Libro24)
		(predecesor Libro0 Libro1)
		(predecesor Libro1 Libro3)
		(predecesor Libro3 Libro5)
		(predecesor Libro4 Libro9)
		(predecesor Libro5 Libro16)
		(predecesor Libro6 Libro19)
		(predecesor Libro7 Libro11)
		(predecesor Libro8 Libro18)
		(predecesor Libro9 Libro12)
		(predecesor Libro11 Libro21)
		(predecesor Libro12 Libro14)
		(predecesor Libro13 Libro15)
		(predecesor Libro20 Libro24)
		(paralelo Libro0 Libro4)
		(paralelo Libro4 Libro0)
		(paralelo Libro1 Libro7)
		(paralelo Libro7 Libro1)
		(paralelo Libro2 Libro19)
		(paralelo Libro19 Libro2)
		(paralelo Libro3 Libro20)
		(paralelo Libro20 Libro3)
		(paralelo Libro4 Libro22)
		(paralelo Libro22 Libro4)
		(paralelo Libro5 Libro25)
		(paralelo Libro25 Libro5)
		(paralelo Libro8 Libro21)
		(paralelo Libro21 Libro8)
		(paralelo Libro9 Libro15)
		(paralelo Libro15 Libro9)
		(paralelo Libro11 Libro24)
		(paralelo Libro24 Libro11)
		(paralelo Libro17 Libro18)
		(paralelo Libro18 Libro17)
	)

	(:goal
		; Para todos los libros que se quieren leer, asignados.
		(forall (?l - libro) (imply (quiere_leer ?l) (asignado ?l)))
	)
)
