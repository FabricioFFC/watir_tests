require 'rubygems'
#require 'watir'
require 'firewatir'
require 'lib/watir_helper.rb'

module Twitter

  class HomePage
    include WatirHelper

    HOME_PAGE = 'twitter.com'

    link(:tweet_button, :class => 'tweet-button button')
    link(:tweet_button_disable, :class => 'tweet-button button disabled')
    text_field(:username, :name => 'session[username_or_email]')
    text_field(:password, :name => 'session[password]')
    text_field(:editor, :class => 'twitter-anywhere-tweet-box-editor')
    button(:sign_in_submit, :class => 'submit button')
    div(:message, :class => 'tweet-text')

    def initialize
      @browser = Watir::Browser.new
    end

    def visit
      @browser.goto(HOME_PAGE)
    end

    def login(username, password)
      self.username = username
      self.password = password
      self.sign_in_submit
    end

    def type_message(message)
      self.editor = message
      self.editor_text_field.fire_event('onMouseDown')
    end

    def tweet
      self.tweet_button
    end

    def message_exists?(message)
      @browser.wait_until {self.message_div.text == message}
    end

    def alert_message_exists?(message)
      @browser.wait_until {@browser.text.include? message}
    end

    def tweet_button_is_disabled?
      @browser.link(self.tweet_button_disable_link.exists?)
    end

  end
end

