extraer.cal <- function(tarea = 1, dbname = 'aprendizaje', user='evaluador', password='bowles'){
	require(RMySQL)

	con <- dbConnect(MySQL(), host = 'localhost',
		dbname = dbname, user = user, password = password)

	query.1 <- paste('select entregas.IDentrega, entregas.IDusuario,',
		'entregas.tarea, entregas.ejercicio, entregas.evaluado, entregas.calificacion',
		'from entregas left join usuarios',
		'on entregas.IDusuario = usuarios.IDusuario where entregas.tarea=',
		tarea, 'order by usuarios.IDusuario')

	rs <- dbSendQuery(con, query.1)
	data <- fetch(rs, n = -1)
	data
#	save(data, file = '../salida.Rdata'
}
