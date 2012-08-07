# -*- coding: utf-8 -*-
# Aplicación de sinatra
require 'rubygems'
require 'sinatra'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['admin', 'admin']
end

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


