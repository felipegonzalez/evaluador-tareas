# -*- coding: utf-8 -*-
# Aplicación de sinatra

require 'sinatra'

get '/' do
  'Evaluador de Tareas'
end

post '/evaluador' do
  # recibir los paramétros
  nombre = params[:nombre]
  my_key = params[:my_key]
  tarea = params[:tarea]
  ejercicio = params[:ejercicio]
  funcion = params[:funcion]
  puts(funcion)
  "Recibido"
end
