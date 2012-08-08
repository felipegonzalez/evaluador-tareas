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
(con sudo).

4) Configurar mysql

- Crear usuario evaluador (en consola de mysql) 

	create user 'evaluador'@'localhost' identified by 'password';
	create database Evaluador character set 'utf8';
    grant all on aprendizaje.* to evaluador@localhost;

- Crear tablas

	mysql -u evaluador -p --verbose < crear_tablas.sql 

- Agregar un usuario de prueba

	use aprendizaje;



Cómo usar
---------

