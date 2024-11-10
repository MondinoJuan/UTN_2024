NOTAS IMPORTANTES 

1) Este ejemplo es una propuesta de resolución del examen, en algunos casos se implementaron algunas cosas más para que también sea a futuro una referencia para el TPI. 

2) Tener presente que es solo UNA propuesta, por lo que NO es la ÚNICA opción válida. 

3) El mismo no está 100% finalizado, siendo que siempre es posible mejorar la implementación con más tiempo. En algunos lugares de dejaron comentarios con posibles mejoras. Obviamente no se esperaba que estas mejoras sean consideradas por el alumno en el parcial. 

4) En donde dice “Inmobiliaria” (nombre de la SLN, carpetas, nombre de los proyectos, namespace) se esperaba que el alumno pusiera su apellido. 

	Ejemplo supuniendo que el apellido es "Perez" entonces: 

	Nombre de la solución: Perez.sln
	
	Proyectos:
		Inmobiliaria.WebApi -> Perez.WebApi
		Inmobiliaria.Domain -> Perez.Domain
		Inmobiliaria.UI.Desktop -> Perez.UI.Desktop
		
	Idem carpetas y namespaces.

5) Se crea un "PropiedadDto" y "TipoPropiedadDto" que busca desacoplar 100% el backend del frontend. A los fines del examen era válido "compartir" la entidad Propiedad. Si es importante que el alumno comprenda el impacto de acoplamiento que esto genera desde lo conceptual. 

6) Se implementan algunas validaciones del lado del cliente y otras del lado del servidor para mostrar cómo se podría haber avanzado. Para el alcance del parcial ambas opciones son válidas. Tener presente que, en un sistema real, nuestra API de servicios nunca puede "confiarse" de que la presentación va a realizar estas validaciones, por lo que al menos en el backend las mismas debería estar y probablemente algunas las deberíamos redundar por usabilidad. 

7) Tanto la URL de los endpoints, como el string de conexión en un ejemplo real se recomienda moverlos a un archivo de configuración que nos dé la posibilidad de ajustarlos sin tener que recompilar la solución. 

8) Notar que hay dos clases que se llaman PropiedadDto, una del lado del frontend y otra del lado del backend. Se duplica para evitar agregar un nuevo proyecto. Como se mencionó antes, esto requería agregar más clases ya que también es necesario implementar el método ToDto en el servicio para poder mapear de la entidad al Dto. Para el parcial era válido usar siempre la misma entidad. Esto se agregó para poder cumplimentar el requerimiento de Aprobación directa de la consulta. Notar que se "aplana" en propiedades, el campo descripción de tipo de propiedad. 

9) Depuración y prueba: A los fines de la depuración se configuró que arranquen inicialmente el proyecto de presentación y el web api. Recordar que esto se puede modificar haciendo botón derecho en la solución y cambiando los proyectos de inicio de múltiple por single. 

10) Nombres de proyectos: Se podrían haber usado otros nombres en la medida que sean representativos. Se mantuvieron los que fueron mencionados mayormente durante el cursado. Dejamos algunas variantes: 
	- Para domain por ejemplo se podría utilizar AppCore o simplemente Core que son términos que aparecen en varios libros de referencia. 

	- Para presentación se podría haber utilizado simplemente UI, Escritorio, Desktop, Winform, Presentación, etc. Se opto por esta opción para dejarlo preparado si se quiere agregar un proyecto Web. 

	- WebAPI podría ser Endpoints, Api, PubliAPI, etc. 

Era válido crear otros proyectos adicionales para mejorar el desacoplamiento. Ejemplos: una capa de entidades, sacar el contexto de EF a un proyecto de Infraestructura. Mover los API clients en otro proyecto. Todas estas cosas, que son perfectamente válidas, no las recomendamos para el parcial ya que agregan complejidad y siempre vamos a tener un tiempo acotado. 

11) En las pantallas se podría mejorar la estética, como así también ajustar el nombre de las columnas de la grilla. Notar por ejemplo que TipoPropiedadId no tendría sentido que siga saliendo una vez implementado el requerimiento de Aprobación directa ya que agregamos el campo descripción del tipo de propiedad. 

 