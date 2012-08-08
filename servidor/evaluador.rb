# -*- coding: utf-8 -*-
# Aplicación de sinatra
require 'rubygems'
require 'sinatra'
require 'mysql'
require 'haml'

set :port, 80
set :haml, :format => :html5
set :views, settings.root + '/templates'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  # hacer consultas a la base de datos para hacer la autenticación
  con = Mysql.new('localhost','evaluador','bowles','aprendizaje')
  res = con.query("select * from usuarios where nombre = '#{username}' and pass = '#{password}'")
  con.close()
  res.num_rows() >= 1
end

get '/' do
  haml :home
end

post '/evaluador' do
  # recibir los paramétros
  nombre = params[:nombre]
  my_key = params[:my_key]
  tarea = params[:tarea]
  ejercicio = params[:ejercicio]
  funcion = params[:funcion]
  con = Mysql.new('localhost','evaluador','bowles','aprendizaje')
  #1.sacar el id
  #2. insertar en tabla de tareas
  con.close()
  "Recibido"
end


