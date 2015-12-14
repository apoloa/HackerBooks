# HackerBooks

Es un lector de libos en PDF para iPhone y iPad. Los libros se descargan de forma asincrona de un enlace ofrecido. 

Se ha creado la clase Book, que contiene los datos del libro. Después se ha creado una clase Library que contiene los libros.

## isKindOfClass 

IsKindOfClass indica si un objeto hereda de una clase dada. Podemos emplear los casteos (**as**), los casteos permite cambiar de un AnyObject a un objeto más especifico. Para el casteo se requiere que esa variable tenga implemtenda la transformación de tipo. Después podemos emplear una conversión forzada, para ello empleamos el comando **is**

```
is = as! 
```
Podemos emplear una convesion a opcional (**as?**) empleando si da un formato incorrecto ***nil***.

## Optimización de datos

Se ha empleado una descarga activa de imagenes, una vez iniciada descarga las portadas de los libros y las guarda en el dispositivo. Para ello se ha creado un gestor de ficheros que permite comprobar si existe en memoria el fichero. Para la descarga de los libros se ha realizado una carga pasiva, donde el usuario apretará sobre "Descargar" para descargar el libro. Se muestra una barra de proceso mientras se descarga susodicho libro. 

## Favoritos

Se puede implementar los delegados, que implican una referencia a su delegado y las Notificaciones que puede ser que no lleguen al destino, en este caso se ha empleado las notificaciones por que ya tengo un delegado en el Book y eso me incluia añadir más lineas en la clase Book.

## Actualización de datos en la tabla
Se ha empleado la actualización de reloadData(). El método reloadData recarga unicamente las celdas que se ven en pantalla, que dependiendo que dispostivio tengamos serán menos o más. Cuando nos desplazamos por la tabla los datos que se obtienen son unicamente los que están en pantalla. Por eso no me supone una aberración muy elevada. Existen alternativas para modificar solo elementos especificos de la tabla. 

## Extras

1. Un cambio de diseño más limpio de la aplicación y la posiblidad de compra, la creación de más test unitarios y test de UI. Refactoring de algún codigo que no me parece muy ordenado. 

2. Se ha creado un diseño empleando un poco de la magia de las Extensiones.

3. Se podria crear un navegador web con persistencia de paginas.


## Apuntes

* Se ha empleado descargas asincronas para todo el proyecto. 
* Se ha creado extension de UIImage para generar el color medio de la imagen para poner de fondo de la UIView el color de la portada. 
* Se ha creado extension de UIColor para ver si el color obtenido por el UIImage anterior es oscuro. Si es oscuro se actualiza la UI para hacer más visible la interfaz.
* Se han creado dos notificaciones:
	1. Actualizar por primera vez un libro, para que la interfaz no se llene vacia.
	2. Para los favoritos, para que se actualizen
* Se han creado 2 delegados:
	1. Permite notificar al controlador de la tabla que se ha insertado un nuevo libro en el modelo y que actualize la tabla con los nuevos datos. 
	2. Permite un progressBar empleando las URLSessions para descarga el libro y se notifique al usuario actualizando, se permite más de una descarga a la vez y se cambia de libro muestra los datos descargandose actualizando la progressBar. 

