library(RMySQL)
library(RCurl)
library(R.utils)
library(yaml)

# consulta y extracción de SQL
config <- yaml.load_file('../servidor/config.yml')

con = dbConnect(MySQL(), host=config$servidor,
        dbname=config$bd, user=config$user, password=config$pass)
query.1 <- 'select IDentrega, IDusuario, tarea, ejercicio, objeto, evaluado, calificacion from entregas where evaluado=0'
rs <- dbSendQuery(con, query.1)
datos <- fetch(rs, n=-1)
print('Procesando extraccion')
print(datos)
# calificación
if(nrow(datos) >0 ) {
  for(i in 1:nrow(datos)){ # para cada fila de la consulta

    # evaluar la función recibida
    funcion.1.txt <- unserialize(charToRaw(base64Decode(datos[i,'objeto'])))
    funcion <- try(eval(parse(text=funcion.1.txt)), silent=TRUE)
    print(funcion)

    # verificar si hay error en la evaluación
    if("try-error" %in% class(funcion)){
      correcto<- FALSE
    } else {

      # obtener archivos de evaluación y prueba
      raiz.pruebas <- paste('prueba_',datos[i,'tarea'],
                            '_',datos[i,'ejercicio'],
                            sep='' )
      raiz.sol <- paste('sol_',
                        datos[i,'tarea'],'-',
                        datos[i,'ejercicio'])
      archivos <- list.files(path="pruebas",
                             pattern=raiz.pruebas)
      source(paste("./soluciones/",raiz.sol,".R",sep=""))
    
      for(f in archivos){ 
        source(paste("pruebas/",f,sep=""))
        texto.eval <- paste(raiz.pruebas,'(funcion,',raiz.sol,')',sep="")
        resultado <- evalWithTimeout(try(eval(parse(text=texto.eval)),
                                         silent=TRUE),
                                     timeout=20,  onTimeout="error") 
        print(resultado)
        # si hubo un error en la evaluación o tuvo un error (ejercicio mal)
        if("try-error" %in% class(resultado) || resultado){
          correcto <- FALSE; break
        }
      
        correcto <- TRUE
      }
      calificacion <- correcto*10
      print('Actualizar base de datos')
      query.fin.1 <- paste('update entregas set evaluado=1, calificacion=',
                           calificacion,sep='') 
      query.fin.2 <- paste( query.fin.1,
                           ' where IDentrega=',
                           datos[i,'IDentrega'],
                           sep='')
      rs.1 <- dbSendQuery(con, query.fin.2)
    }
  }
}
dbDisconnect(con)
