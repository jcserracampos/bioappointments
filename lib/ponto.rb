# frozen_string_literal: true

require 'sinatra'
require 'sqlite3'

DB = SQLite3::Database.new 'appointments.db'

DB.execute <<-SQL
  create table if not exists daily (
    type varchar(10),
    time varchar(30)
  );
SQL

CHOICES = {
  'entrada' => 'Entrada',
  'saida' => 'Saída',
  'almoco' => 'Saída para Almoço',
  'almoco2' => 'Retorno do Almoço'
}.freeze

get '/' do
  erb :index
end

post '/ponto' do
  @title = 'Ponto lançado'
  @type = params['type']
  @time = DateTime.now.to_s

  DB.execute 'INSERT into daily values (?, ?)', @type, @time

  erb :ponto
end

get '/results' do
  @appointments = DB.execute 'select * from daily'
  @title = 'Fechamento do Dia'
  erb :results
end
