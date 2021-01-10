require 'sinatra/base'

def players_setup()
  session['player1'], session['player2'] = params[:player1], params[:player2]
  session['current_player'] = params[:player1]
  session['player1HP'] = 50
  session['player2HP'] = 50
  session['player1MaxHP'] = session['player1HP']
  session['player2MaxHP'] = session['player2HP']
end

def game_finished?()
  if @player1HP == 0
    redirect to("/player1-lost")
  end
  if @player2HP == 0
    redirect to("/player2-lost")
  end
end

class Battle < Sinatra::Base
  enable :sessions

  get '/' do
    'Testing infrastructure working!'
  end

  get '/names' do
    erb(:index)
  end

  get '/play' do
    @player1, @player2 = session['player1'], session['player2']
    @current_player = session['current_player']
    @player1HP, @player2HP = session['player1HP'], session['player2HP']
    @player1MaxHP, @player2MaxHP = session['player1MaxHP'], session['player2MaxHP']
    game_finished?()
    erb(:game_begin)
  end

  post '/play' do
    players_setup()
    redirect to("/play")
  end

  get '/game_begin' do
    erb(:game_begin)
  end

  get '/attack-confirmation' do
    @player = session['player2']
    @player_number = 2
    erb(:attack_confirmation)
  end

  get '/attack-confirmation2' do
    @player = session['player1']
    @player_number = 1
    erb(:attack_confirmation)
  end

  get '/player1-damage' do
    currentHP = session['player1HP']
    currentHP -= 10
    session['player1HP'] = currentHP
    session['current_player'] = session['player1']
    redirect to("/play")
  end

  get '/player2-damage' do
    currentHP = session['player2HP']
    currentHP -= 10
    session['player2HP'] = currentHP
    session['current_player'] = session['player2']
    redirect to("/play")
  end

  get "/player1-lost" do
    @player1, @player2 = session['player1'], session['player2']
    "#{@player2} won!\n#{@player1} lost!"
  end

  get "/player2-lost" do
    @player1, @player2 = session['player1'], session['player2']
    "#{@player1} won!\n#{@player2} lost!"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
