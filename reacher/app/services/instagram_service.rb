require 'watir'
# require 'google/cloud/vision'

class InstagramService

  def initialize(username, hashtag, count)
    @start_time  = DateTime.now
    @adjectives  = %w(really_sweet so_cool awesome pretty_sweet spectacular super perfect).map { |item| item.gsub('_',' ') }
    @end_comment = %w(I'll_be_there_soon I'll_be_there_too I'm_saving_up Can't_wait_to_get_out_there I'm_jealous).map { |item| item.gsub('_',' ') }
    @timeframes  = %w(weeks months)
    @client      = Client.where(instagram_username: username).first
    @browser     = Watir::Browser.new :chrome
    @instagram   = InstagramVariablesService.new @browser
    @hashtag     = hashtag
    @count       = count
    @posts       = []
  end

  def run
    login
    search_for_hashtag
    load_posts until @instagram.posts.count >= @count + 9
    like_posts
  end

  def follow_users
    sleep_random 5
    User.where("created_at > '#{@start_time}'").map do |user|
      @browser.goto "https://www.instagram.com/#{user.username}/"
      sleep_random 3
      if @instagram.follow_button.exists?
        Follow.create(user: user, client: @client)
        @instagram.follow_button.click
      end
      sleep_random 1
    end
  end

  def login
    @browser.goto "https://www.instagram.com/accounts/login"
    sleep_random
    set_username_and_password
    @instagram.log_in_button.click
  end

  def search_for_hashtag
    @instagram.search_field.set "##{@hashtag}"
    sleep_random
    @browser.link(href: "/explore/tags/#{@hashtag}/").click
    sleep_random
  end

  def load_posts
    @instagram.load_more_button.click if @instagram.load_more_button.exists?
    @instagram.scroll_down(5000)
    sleep_random
  end

  def like_posts
    @instagram.posts.each { |s| @posts << s }
    @posts.shift 9
    @posts.first(@count).map do |post|
      post.click
      sleep_random 2
      username = @instagram.username
      user     = User.where(username: username).first_or_create
      InstagramPost.create(url: @browser.url, image_url: @instagram.image_url, user: user)
      @instagram.heart.click
      sleep_random 10
      comment_on_post if @instagram.comment_box.exists? && User.where(username: username).count <= 1

      @instagram.exit_post_button.click
    end
  end

  def comment_on_post
    @instagram.comment_box.click
    num       = rand(2..9)
    timeframe = @timeframes.sample
    timeframe.sub!('s','') if num == 1
    @browser.send_keys "This is #{@adjectives.sample}. #{@end_comment.sample}! #{num} more #{timeframe}!"
    @browser.send_keys :enter
  end

  def set_username_and_password
    @browser.text_field(name: 'username').set @client.instagram_username
    @browser.text_field(name: 'password').set @client.instagram_password
  end

  def sleep_random(floor = nil)
    num = floor ? "#{rand floor..floor + 1}.#{second_fraction}" : "1.#{second_fraction}"
    sleep num.to_f
  end

  def second_fraction
    rand(0..9)
  end
end
