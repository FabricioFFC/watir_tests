require 'spec_helper'

USERNAME = 'username'
PASSWORD = 'password'
MESSAGE = 'Watir rocks!'
MESSAGE_WITH_MORE_THAN_140_CHARACTERS =  "testing characters limit. 140 characters is the
  characters limit. Are you pass? not yet? not? not? when are we pass? now? We break the limit!"
TWITTER_REPEATED_MESSAGE = 'Whoops! You already said that...'

describe Twitter::HomePage do

  before(:all) do
    @home_page = Twitter::HomePage.new
    @home_page.visit
    @home_page.login(USERNAME,PASSWORD)
  end

  it "send a message when it is valid" do
    @home_page.type_message(MESSAGE)
    @home_page.tweet
    @home_page.message_exists?(MESSAGE).should be_true
  end

  it "return a error messagem when try to send a repeated message" do
    @home_page.type_message(MESSAGE)
    @home_page.tweet
    @home_page.alert_message_exists?(TWITTER_REPEATED_MESSAGE).should be_true
  end

  it "don't allow to send a message when it contains more than 140 characters" do
    @home_page.type_message(MESSAGE_WITH_MORE_THAN_140_CHARACTERS)
    @home_page.tweet_button_is_disabled?.should be_true
  end

  it "don't allow to send a message when it is blank" do
    @home_page.type_message('')
    @home_page.tweet_button_is_disabled?.should be_true
  end

end

