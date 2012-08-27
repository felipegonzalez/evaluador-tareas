# -*- coding: utf-8 -*-
# Aplicación de sinatra
require 'rubygems'
require 'sinatra'
require 'mysql'
require 'haml'
require 'yaml'

set :port, 80
set :haml, :format => :html5
set :views, settings.root + '/templates'

# configuracion
configure do
#  enable :sessions
  conf = open('./config.yml') { |f| YAML.load(f)}
  set :servidor, conf['servidor']
  set :user, conf['user']
  set :pass, conf['pass']
  set :bd, conf['bd']
end

use Rack::Auth::Basic do |username, password|
  # hacer consultas a la base de datos para hacer la autenticación
  con = Mysql.new(settings.servidor,settings.user,settings.pass,settings.bd)
  res = con.query("select * from usuarios where nombre = '#{username}' and pass = '#{password}'")
  con.close()
#  session[:username] = username
  res.num_rows() >= 1
end

# redirecciones a templates

# ver resultados (página principal)
get '/' do
  @username = env['REMOTE_USER']
  con = Mysql.new(settings.servidor,settings.user,settings.pass,settings.bd)
  res = con.query("select IDusuario from usuarios where nombre='#{@username}'")
  if res.num_rows >= 1
    row = res.fetch_row
    id = row[0]
    con.close()
    con = Mysql.new(settings.servidor,settings.user,settings.pass,settings.bd)
    @res = con.query("select tarea, ejercicio, calificacion from entregas where IDusuario = '#{id}' and evaluado = 1")
    haml :resultados
  else
    redirect to('/')
  end 
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
  con = Mysql.new(settings.servidor,settings.user,settings.pass,settings.bd)
  res = con.query("select IDusuario from usuarios where nombre='#{usuario}' and pass = '#{pass}'")  
  if res.num_rows >= 1
    row = res.fetch_row
    id = row[0]
    con.close()
    con = Mysql.new(settings.servidor,settings.user,settings.pass,settings.bd)
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
  puts("Recibido de #{nombre}")
  puts("Tarea #{tarea} Ejercicio #{ejercicio}")
  con = Mysql.new(settings.servidor,settings.user,settings.pass,settings.bd)
  res = con.query("select IDusuario from usuarios where nombre='#{nombre}' and pass='#{pass}'")
  if res.num_rows >= 1
    row = res.fetch_row
    id = row[0]
    con.close()
    # checar el timestamp
    con = Mysql.new(settings.servidor,settings.user,settings.pass,settings.bd)
    res = con.query("select max(ts) from entregas where IDusuario='#{id}'")
    aceptar = true
    if res.num_rows >= 1
      row = res.fetch_row
      ts = row[0]
      ultimo = DateTime.strptime(ts,"%Y-%m-%d %H:%M:%S")
      limite = DateTime.now
      puts("En #{ultimo}")
      dif = ((limite - ultimo)*24*60).to_i
      if dif < 10 
        aceptar = false
        restante = 10 - dif
        res = "Tienes que esperar #{restante} minuto(s)\n"
      end
    end
    if aceptar 
      # recibir el ejercicio
      con = Mysql.new(settings.servidor,settings.user,settings.pass,settings.bd)
      con.query("insert into entregas (IDusuario,tarea,ejercicio,objeto,evaluado,calificacion) values (#{id},#{tarea},#{ejercicio},'#{funcion}',0,NULL)")
      res ="Recibido\n"
    end
  else
    res = "Fallo\n"
  end
  res
end


