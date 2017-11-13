class InstagramVariablesService

  def initialize browser
    @browser = browser
  end

  def comment_box
    @browser.textarea(class: "_bilrf")
  end

  def exit_post_button
    @browser.button(class: "_dcj9f")
  end

  def follow_button
    @browser.button(value: "Follow")
  end

  def heart
    @browser.span(class: "coreSpriteHeartOpen")
  end

  def image_url
    @browser.img(class: "_2di5p").src
  end

  def password_field
    @browser.text_field(name: 'password')
  end

  def load_more_button
    @browser.a(text: "Load more")
  end

  def log_in_button
    @browser.button(value: 'Log in')
  end

  def posts
    @browser.divs(class: "_si7dy")
  end

  def retry_button
    @browser.a(class: "_rke62")
  end

  def scroll_down amount
    @browser.driver.execute_script("window.scrollBy(0,#{amount})")
  end

  def scroll_up amount
    @browser.driver.execute_script("window.scrollBy(0,-#{amount})")
  end

  def search_field
    @browser.text_field(placeholder: 'Search')
  end

  def username
    @browser.a(class: "_iadoq").text.downcase
  end

  def username_field
    @browser.text_field(name: 'username')
  end
end
