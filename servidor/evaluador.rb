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

# redirecciones a templates

get '/' do
  haml :home
end

get '/cambiar' do
  haml :cambiar
end

# Cambiar contraseña

post '/cambiarP' do
  usuario = params[:nombre]
  pass = params[:pass]
  npass = params[:npass]
  # hacer consulta para ecnontrar el id de usuario
  con = Mysql.new('localhost','evaluador','bowles','aprendizaje')
  res = con.query("select IDusuario from usuarios where nombre='#{usuario}' and pass = '#{pass}'")  
  puts(res.num_rows)
  if res.num_rows >= 1
    row = res.fetch_row
    id = row[0]
    con.close()
    con = Mysql.new('localhost','evaluador','bowles','aprendizaje')
    con.query("update usuarios set pass ='#{npass}' where IDusuario =#{id}")
    con.close()
  else
    con.close()
    redirect to('/cambiar')
  end
  redirect to('/')
end

# recibir y guardar las tareas

post '/evaluador' do
  # recibir los paramétros
  nombre = params[:nombre]
  pass = params[:pass]
  tarea = params[:tarea]
  ejercicio = params[:ejercicio]
  funcion = params[:funcion]
  con = Mysql.new('localhost','evaluador','bowles','aprendizaje')
  res = con.query("select IDusuario from usuarios here nombre='#{nombre}' and pass='#{pass}'")
  if res.num_rows >= 1
    row = res.fecht_row
    id = row[0]
    con.close()
    con = Mysql.new('localhost','evaluador','bowles','aprendizaje')
    con.query("insert into usuarios (IDusuario,tarea,ejercicio,objeto,evaluado,calificacion) value (#{IDusuario},#{tarea},#{ejercicio},#{funcion},NULL,NULL)")
    res ="Recibido"
  else
    res = "Fallo"
  end
  res
end


