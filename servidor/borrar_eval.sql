-- Script para borrar las calificaciones de la base

use aprendizaje;

update entregas set evaluado = 0, calificacion = NULL;
