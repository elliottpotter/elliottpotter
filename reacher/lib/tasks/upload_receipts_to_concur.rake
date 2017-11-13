require 'net/http'

namespace :upload do

  desc "Upload receipts to concur"
  task receipts_to_concur: :environment do
    @browser = Watir::Browser.new :phantomjs
    @browser.goto "http://marinellahumecasting.com/castme/index.php"
    @browser.span(id: "sign_in_button_text").click
    sleep 2
    @browser.input(id: "login_username").click
    @browser.input(id: "login_username").send_keys "epotter04@gmail.com"
    @browser.input(placeholder: "your password").click
    @browser.input(placeholder: "your password").send_keys "Getification1"
    @browser.span(text: "SIGN IN").click
    sleep 3
    notifications = @browser.div(id: "notices_text").text
    APIService.new("https://hooks.zapier.com/hooks/catch/631013/idm8ky/").post_request({}, "notifications" => notifications)
  end
end
