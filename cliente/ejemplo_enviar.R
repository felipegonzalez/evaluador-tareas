library(RCurl)

## Este es un prototipo de cómo debe funcionar el cliente

enviar.fun <- function(nombre, my_key, funcion.archivo, tarea, ejercicio, nombre.fun){
   serv.1 <- 'http://ec2-23-22-6-197.compute-1.amazonaws.com' #para pruebas locales
   servidor <- paste(serv.1,"/evaluador", sep="") 
   con <- file(funcion.archivo, "r", blocking = TRUE)
   #serializar archivo
   texto.fun <- as.character(base64Encode(rawToChar(serialize(readLines(con), ascii=TRUE, connection=NULL))))
   close(con)
   print("ok")
   curl = getCurlHandle()
   curlSetOpt(.opts = list(userpwd = paste(nombre,my_key,sep=":")),
              curl = curl)
   # autenticacion
   html <- postForm(servidor, nombre = nombre, pass=my_key, tarea=tarea,ejercicio=ejercicio, funcion=texto.fun, style="httppost",
      .encoding='utf-8',curl=curl)
   cat(html)
   cat('Puedes ver tus resultados en: \n')
   cat(serv.1)
   cat('\n')
}


enviar <- function(){
   cat("Nombre:")
   nombre <- scan(what=character(), n=1, quiet=TRUE)
   cat("Clave:")
   my_key <- scan(what=character(), n=1, quiet =TRUE)
   cat("Cuál quieres enviar: \n")
   cat("---Tarea 1-----\n")
   cat("1 logit.R\n")
   cat("2 J_perdida.R\n")
   cat("3 J_gradiente.R\n")
   cat("4 descenso.R\n")
   parte <- scan(what=double(), n = 1, quiet=TRUE)
   # parametros de archivos y tareas para mandar
   #print(parte)
   funcion.archivo <- switch(as.integer(parte),
                             "logit.R",
                             "J_perdida.R",
                             "J_gradiente.R",
                             "descenso.R")
   nombre.fun <- switch(as.integer(parte),
                        "g",
                        "J.perdida",
                        "J.grad",
                        "descenso")
   tarea <- as.character(1)
   ejercicio <- as.character(parte)
   if(as.integer(parte) <= 4){
     enviar.fun(nombre=nombre,
                my_key=my_key,
                funcion.archivo=funcion.archivo,
                tarea=tarea,
                ejercicio=ejercicio)
   }

}

enviar()


