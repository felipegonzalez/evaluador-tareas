-- Crear tablas para la base de SQL
use aprendizaje;

create table if not exists usuarios (
       IDusuario      int		NOT NULL	AUTO_INCREMENT,
       clave	      varchar(10)	NOT NULL,
       nombre	      varchar(100)	NOT NULL,
       pass	      text		NOT NULL,
       primary key(IDusuario));

create table if not exists entregas (
       IDentrega 	      int		NOT NULL	AUTO_INCREMENT,
       IDusuario	      int		NOT NULL,
       tarea		      int		NOT NULL,
       ejercicio	      int		NOT NULL,
       objeto		      text		NOT NULL,
       evaluado		      boolean		NOT NULL,
       calificacion	      int		NULL,
       primary key(IDentrega));
