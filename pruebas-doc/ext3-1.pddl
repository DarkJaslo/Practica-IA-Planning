; DEBUG: DAG con 30 libros:
; prerequisitos on
; paralelos on
; npaginas on
; Fichero generado con el programa, seed 360
(define (problem Libros-base)
	(:domain Lectura)
	(:objects
		Casper Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre - mes
		Libro0 Libro1 Libro2 Libro3 Libro4 Libro5 Libro6 Libro7 Libro8 Libro9 Libro10 Libro11 Libro12 Libro13 Libro14 Libro15 Libro16 Libro17 Libro18 Libro19 Libro20 Libro21 Libro22 Libro23 Libro24 Libro25 Libro26 Libro27 Libro28 Libro29 - libro
	)

	(:init
		; Datos universales
		(inm_anterior Casper Enero) (inm_anterior Enero Febrero) (inm_anterior Febrero Marzo) (inm_anterior Marzo Abril) (inm_anterior Abril Mayo) (inm_anterior Mayo Junio) (inm_anterior Junio Julio) (inm_anterior Julio Agosto) (inm_anterior Agosto Septiembre) (inm_anterior Septiembre Octubre) (inm_anterior Octubre Noviembre) (inm_anterior Noviembre Diciembre) 
		(anterior Enero Febrero) (anterior Enero Marzo) (anterior Enero Abril) (anterior Enero Mayo) (anterior Enero Junio) (anterior Enero Julio) (anterior Enero Agosto) (anterior Enero Septiembre) (anterior Enero Octubre) (anterior Enero Noviembre) (anterior Enero Diciembre) (anterior Febrero Marzo) (anterior Febrero Abril) (anterior Febrero Mayo) (anterior Febrero Junio) (anterior Febrero Julio) (anterior Febrero Agosto) (anterior Febrero Septiembre) (anterior Febrero Octubre) (anterior Febrero Noviembre) (anterior Febrero Diciembre) (anterior Marzo Abril) (anterior Marzo Mayo) (anterior Marzo Junio) (anterior Marzo Julio) (anterior Marzo Agosto) (anterior Marzo Septiembre) (anterior Marzo Octubre) (anterior Marzo Noviembre) (anterior Marzo Diciembre) (anterior Abril Mayo) (anterior Abril Junio) (anterior Abril Julio) (anterior Abril Agosto) (anterior Abril Septiembre) (anterior Abril Octubre) (anterior Abril Noviembre) (anterior Abril Diciembre) (anterior Mayo Junio) (anterior Mayo Julio) (anterior Mayo Agosto) (anterior Mayo Septiembre) (anterior Mayo Octubre) (anterior Mayo Noviembre) (anterior Mayo Diciembre) (anterior Junio Julio) (anterior Junio Agosto) (anterior Junio Septiembre) (anterior Junio Octubre) (anterior Junio Noviembre) (anterior Junio Diciembre) (anterior Julio Agosto) (anterior Julio Septiembre) (anterior Julio Octubre) (anterior Julio Noviembre) (anterior Julio Diciembre) (anterior Agosto Septiembre) (anterior Agosto Octubre) (anterior Agosto Noviembre) (anterior Agosto Diciembre) (anterior Septiembre Octubre) (anterior Septiembre Noviembre) (anterior Septiembre Diciembre) (anterior Octubre Noviembre) (anterior Octubre Diciembre) (anterior Noviembre Diciembre) 
		(= (paginas-leidas Enero) 0)
		(= (paginas-leidas Febrero) 0)
		(= (paginas-leidas Marzo) 0)
		(= (paginas-leidas Abril) 0)
		(= (paginas-leidas Mayo) 0)
		(= (paginas-leidas Junio) 0)
		(= (paginas-leidas Julio) 0)
		(= (paginas-leidas Agosto) 0)
		(= (paginas-leidas Septiembre) 0)
		(= (paginas-leidas Octubre) 0)
		(= (paginas-leidas Noviembre) 0)
		(= (paginas-leidas Diciembre) 0)
		; Relaciones entre objetos
		(leido Libro5)
		(quiere_leer Libro0)
		(quiere_leer Libro1)
		(quiere_leer Libro2)
		(quiere_leer Libro4)
		(quiere_leer Libro7)
		(quiere_leer Libro8)
		(quiere_leer Libro9)
		(quiere_leer Libro10)
		(quiere_leer Libro12)
		(quiere_leer Libro13)
		(quiere_leer Libro14)
		(quiere_leer Libro15)
		(quiere_leer Libro16)
		(quiere_leer Libro18)
		(quiere_leer Libro19)
		(quiere_leer Libro20)
		(quiere_leer Libro22)
		(quiere_leer Libro23)
		(quiere_leer Libro24)
		(quiere_leer Libro25)
		(quiere_leer Libro27)
		(quiere_leer Libro28)
		(quiere_leer Libro29)
		(predecesor Libro0 Libro11)
		(predecesor Libro1 Libro19)
		(predecesor Libro2 Libro7)
		(predecesor Libro3 Libro23)
		(predecesor Libro4 Libro20)
		(predecesor Libro6 Libro15)
		(predecesor Libro7 Libro18)
		(predecesor Libro8 Libro12)
		(predecesor Libro9 Libro21)
		(predecesor Libro10 Libro16)
		(predecesor Libro14 Libro29)
		(predecesor Libro20 Libro24)
		(predecesor Libro27 Libro28)
		(paralelo Libro0 Libro8)
		(paralelo Libro8 Libro0)
		(paralelo Libro1 Libro3)
		(paralelo Libro3 Libro1)
		(paralelo Libro4 Libro12)
		(paralelo Libro12 Libro4)
		(paralelo Libro5 Libro22)
		(paralelo Libro22 Libro5)
		(paralelo Libro6 Libro11)
		(paralelo Libro11 Libro6)
		(paralelo Libro10 Libro27)
		(paralelo Libro27 Libro10)
		(paralelo Libro11 Libro13)
		(paralelo Libro13 Libro11)
		(paralelo Libro14 Libro19)
		(paralelo Libro19 Libro14)
		(paralelo Libro16 Libro17)
		(paralelo Libro17 Libro16)
		(paralelo Libro24 Libro26)
		(paralelo Libro26 Libro24)
		(= (paginas Libro0) 35)
		(= (paginas Libro1) 78)
		(= (paginas Libro2) 113)
		(= (paginas Libro3) 62)
		(= (paginas Libro4) 50)
		(= (paginas Libro5) 111)
		(= (paginas Libro6) 162)
		(= (paginas Libro7) 175)
		(= (paginas Libro8) 66)
		(= (paginas Libro9) 142)
		(= (paginas Libro10) 170)
		(= (paginas Libro11) 50)
		(= (paginas Libro12) 146)
		(= (paginas Libro13) 71)
		(= (paginas Libro14) 162)
		(= (paginas Libro15) 58)
		(= (paginas Libro16) 77)
		(= (paginas Libro17) 36)
		(= (paginas Libro18) 67)
		(= (paginas Libro19) 85)
		(= (paginas Libro20) 62)
		(= (paginas Libro21) 36)
		(= (paginas Libro22) 71)
		(= (paginas Libro23) 177)
		(= (paginas Libro24) 166)
		(= (paginas Libro25) 149)
		(= (paginas Libro26) 75)
		(= (paginas Libro27) 44)
		(= (paginas Libro28) 144)
		(= (paginas Libro29) 119)
	)

	(:goal
		; Para todos los libros que se quieren leer, asignados.
		(forall (?l - libro) (imply (quiere_leer ?l) (asignado ?l)))
	)
)
