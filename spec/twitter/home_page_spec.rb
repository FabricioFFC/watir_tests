require 'spec_helper'

USERNAME = 'YOUR USERNAME'
PASSWORD = 'YOUR PASSWORD'
MESSAGE = 'testando o Twitter'
MESSAGE_WITH_MORE_THAN_140_CHARACTERS = 'testando o limite de caracteres na mensagem no
  Twitter, chegou? ainda nao? nao? nao? ainda nao? quando vamos chegar? estamos perto? chegamos!'
TWITTER_REPEATED_MESSAGE = 'Whoops! You already said that...'

describe Twitter::HomePage do

  before(:all) do
    @home_page = Twitter::HomePage.new
    @home_page.visit
    @home_page.login(USERNAME,PASSWORD)
  end

  it "envia uma mensagem quando ela é válida" do
    @home_page.type_message(MESSAGE)
    @home_page.tweet
    @home_page.message_exists?(MESSAGE).should be_true
  end

  it "retorna mensagem de erro, ao tentar enviar uma mensagem repetida" do
    @home_page.type_message(MESSAGE)
    @home_page.tweet
    @home_page.alert_message_exists?(TWITTER_REPEATED_MESSAGE).should be_true
  end

  it "não deixa enviar uma mensagem com mais de 140 caracteres" do
    @home_page.type_message(MESSAGE_WITH_MORE_THAN_140_CHARACTERS)
    @home_page.tweet_button_is_disabled?.should be_true
  end

  it "não deixa enviar uma mensagem em branco" do
    @home_page.type_message('')
    @home_page.tweet_button_is_disabled?.should be_true
  end

end

