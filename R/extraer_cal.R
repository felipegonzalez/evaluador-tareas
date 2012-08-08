extraer.cal(tarea = 1, dbname = 'aprendizaje', user='evaluador', password='bowles'){
	require(RMySQL)

	con <- dbConnect(MySQL(), host = 'localhost',
		dbname = dbname, user = user, password = password)

	query.1 <- paste('select entregas.IDentrega, engregas.IDusuario,',
		'entregas.tarea, entregas.ejercicio, entregas.evaluado, entregas.calificacion',
		'from entregas left join usuarios',
		'on entregas.IDusuario = usuarios.IDusuario where entragas.tarea=',
		tarea, 'sort by usuario')

	rs <- dbSendQuery(con, query.1)
	data <- fetch(rs, n = -1)
	data
#	save(data, file = '../salida.Rdata'
}
