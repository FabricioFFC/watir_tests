require 'rubygems'
#require 'watir'
require 'firewatir'

module Twitter

  class HomePage

    HOME_PAGE = 'twitter.com'

    def initialize
      @browser = Watir::Browser.new
    end

    def visit
      @browser.goto(HOME_PAGE)
    end

    def login(username, password)
      @browser.link(:class, "signin").click
      @browser.text_field(:id, 'username').value = username
      @browser.text_field(:id, 'password').value = password
      @browser.button(:id, 'signin_submit').click
    end

    def type_message(message)
      @browser.text_field(:class, 'twitter-anywhere-tweet-box-editor').value = message
      @browser.text_field(:class, 'twitter-anywhere-tweet-box-editor').fire_event("onMouseDown")
    end

    def tweet
      @browser.link(:class, "tweet-button button").click
    end

    def message_exists?(message)
      @browser.wait_until {@browser.div(:class, 'tweet-text').text == message}
    end

    def alert_message_exists?(message)
      @browser.wait_until {@browser.text.include? message}
    end

    def tweet_button_is_disabled?
      @browser.link(:class, "tweet-button button disabled").exists?
    end

  end
end

