evaluador-tareas
================

Evaluador automático de tareas de R

Instalación
-----------
Estas instrucciones funcionan en una instancia de Amazon ec2 Ubuntu 12.04 (por ssh).



1) Instalar ruby, R y mysql

	sudo apt-get update
	sudo apt-get upgrade
	sudo locale-gen UTF-8
	export LC_ALL="en_US.UTF-8"
	sudo apt-get install ruby1.9.1 r-base thin
	sudo apt-get install libcurl4-gnutls-dev

2) Instalar gems de ruby:
	
	sudo gem install sinatra
	sudo gem install haml

3) Instalar RCurl y paquetes adicionales que se requieran para R
(con sudo). Se requieren RmySQL, R.utils, yaml y RCurl

4) Configurar mysql

Crear usuario evaluador (en consola de mysql) 

	create user 'evaluador'@'localhost' identified by 'password';
	create database Evaluador character set 'utf8';
    grant all on aprendizaje.* to evaluador@localhost;

Crear tablas

	mysql -u evaluador -p --verbose < crear_tablas.sql 

Agregar un usuario de prueba

	insert into usuarios (clave,nombre,pass) values (10101,'pedro','pass');

(o tantos usuarios como ser requiere)

5) Preparar servidor

Copiar carpetas de R, cliente, servidor a salidas. 

Configurar parámetros básicos en archivo config.yml (servidor es 'localhost',
y luego nombre de la base, usuario de mysql y su password).


Correr 

	sudo ruby evaluador.rb

6) Checar instalación: abrir http://dirección-de-ip/


Cómo usar
---------

1) Crear usuarios (estudiantes) con algún password. Estos passwords pueden cambiarse. Una vez que se entra al sitio se pueden ver todos los trabajos enviados de ese usuario.

2) Preparar una tarea: escribir un documento (con instrucciones) basado en scripts que dan salidas correctas en cada ejercicio. Se distribuye el documento con instrucciones y las funciones incompletas.

3) Del lado del servidor, subimos las respuestas correctas, y escribimos
funciones de prueba para cada una de las respuestas correctas ???

