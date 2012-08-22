library(RCurl)

## Este es un prototipo de cómo debe funcionar el cliente

enviar.fun <- function(nombre, my_key, funcion.archivo, tarea, ejercicio, nombre.fun){
   servidor <- 'http://ec2-23-22-6-197.compute-1.amazonaws.com/evaluador'
   #servidor.1 <- paste(serv.1, 'aceptar.R', sep='')
   #servidor <- 'http://localhost:4567/evaluador' #para pruebas locales
   con <- file(funcion.archivo, "r", blocking = TRUE)
   #source(funcion.archivo)
   texto.fun <- as.character(base64Encode(rawToChar(serialize(readLines(con), ascii=TRUE, connection=NULL))))
   #print(Encoding(texto.fun)) 
   #Encoding(texto.fun) <- 'UTF-8'
   close(con)
   print("ok")
   #print(texto.fun)
   curl = getCurlHandle()
   curlSetOpt(.opts = list(userpwd = paste(nombre,my_key,sep=":")),
              curl = curl)
   # autenticacion
   html <- postForm(servidor, nombre = nombre, pass=my_key, tarea=tarea,ejercicio=ejercicio, funcion=texto.fun, style="httppost",
      .encoding='utf-8',curl=curl)
   cat(html)
   cat('Puedes ver tus resultados en: \n')
   #cat(paste(serv.1, 'consultar.R', '?nombre=', nombre, sep=''))
   cat('\n')
   }


enviar <- function(){
   cat("Nombre:")
   nombre <- scan(what=character(), n=1, quiet=TRUE)
   cat("Clave:")
   my_key <- scan(what=character(), n=1, quiet =TRUE)
   cat("Cuál quieres enviar: \n")
   cat("tarea_prueba.R  \n")
   parte <- scan(what=double(), n = 1, quiet=TRUE)
   if(as.integer(parte)==1){
     enviar.fun(nombre=nombre,
                my_key=my_key,
                funcion.archivo='tarea_prueba.R',
                tarea="1",
                ejercicio="1",
                nombre.fun='ejemplo')
   }
}

enviar()
