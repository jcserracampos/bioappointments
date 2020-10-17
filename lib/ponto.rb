# frozen_string_literal: true

require 'sinatra'

CHOICES = {
  'entrada' => 'Entrada',
  'saida' => 'Saída',
  'almoco' => 'Almoço'
}.freeze

get '/' do
  erb :index
end

post '/ponto' do
  @title = 'Ponto lançado'
  @type = params['type']
  erb :ponto
end
