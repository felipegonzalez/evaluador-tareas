library(RMySQL)
library(RCurl)
library(R.utils)
#assignInNamespace(
#  "system", 
#  function(...) stop("system calls are not allowed"), 
#  getNamespace("base")
#)

con = dbConnect(MySQL(), host = 'localhost',
        dbname = 'aprendizaje',user = 'evaluador',password = 'bowles')

# Query de no evaluados:
query.1 <- 'select IDentrega, IDusuario, tarea, ejercicio, objeto from entregas where evaluado is false'
rs <- dbSendQuery(con, query.1)
data <- fetch(rs, n = -1)


print('Procesando extraccion')
#print(data)

if(nrow(data) >0 ) {
for(i in 1:nrow(data)){
    funcion.1.txt <- unserialize(charToRaw(base64Decode(data[i, 'objeto'])))
    funcion <- try(eval(parse(text = funcion.1.txt)), silent = TRUE)
    print(funcion)
    if("try-error" %in% class(funcion)){correcto <- 0}
    else{
      raiz.pruebas <- paste('pruebas_',data[i,'tarea'], '_',data[i,'ejercicio'], sep='' )
      archivos <- list.files(pattern = raiz.pruebas)
 
      for(f in archivos){
         print(f)
        source(f)
        resultado <- evalWithTimeout(try(eval(parse(text = paste(f, '(funcion)'))),silent = TRUE),
              timeout = 20,  onTimeout = "error") 
        print(resultado)
        if("try-error" %in% class(resultado)) {correcto <- 0; break}
        if(resultado){correcto <- 0; break}   
      correcto <- 1
    }
}
 print('Actualizar base de datos')
 query.fin.1 <- paste('update entregas set evaluado=true, correcto=',correcto,sep='') 
 query.fin.2 <- paste(query.fin.1, ' where IDentrega =', data[i, 'IDentrega'], sep='')
 rs.1 <- dbSendQuery(con, query.fin.2)
}
}
dbDisconnect(con)
