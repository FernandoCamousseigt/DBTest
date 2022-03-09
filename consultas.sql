--//Realizar las siguientes consultas:

--a. Mostrar todos los libros que posean menos de 300 páginas:
SELECT titulo_libro, paginas_libro 
FROM libro WHERE paginas_libro < 300;

--b. Mostrar todos los autores que hayan nacido después del 01-01-1970:
SELECT nombre_autor, apellido_autor FROM autor 
WHERE fnac_autor>'1970-01-01';

--c. ¿Cuál es el libro más solicitado?

SELECT titulo_libro,
COUNT(*) AS "veces_solicitado" 
FROM libro
INNER JOIN prestamo
ON libro.isbn_libro=prestamo.isbn_libro
GROUP BY libro.titulo_libro
ORDER BY "veces_solicitado" DESC;

--d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto
--debería pagar cada usuario que entregue el préstamo después de 7 días:
--Detallado por libro:
SELECT isbn_libro, nombre_socio, apellido_socio, socio.rut_socio,
(fecha_devolucion - fecha_prestamo - 7)*100 AS "debe"
FROM prestamo 
INNER JOIN socio 
ON prestamo.rut_socio=socio.rut_socio
WHERE ((fecha_devolucion - fecha_prestamo)-7) > 0
ORDER BY socio.rut_socio ASC;


--Opcion2 de d. Lo que debe en multa Total por Usuario (sin detallar por libro)
SELECT nombre_socio, apellido_socio, socio.rut_socio,
SUM(fecha_devolucion - fecha_prestamo - 7)*100 AS "debe"
FROM prestamo 
INNER JOIN socio 
ON prestamo.rut_socio=socio.rut_socio
WHERE ((fecha_devolucion - fecha_prestamo)-7) > 0
GROUP BY socio.rut_socio;
