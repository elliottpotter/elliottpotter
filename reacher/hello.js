var links = [];
var values = {};
var casper = require('casper').create();
var utils = require('utils');

casper.options.onResourceRequested = function(C, requestData, request) {
    if(requestData.url === "https://www.allflicks.net/wp-content/themes/responsive/processing/processing_us.phpp") {
        utils.dump(requestData);
    }
};
// casper.options.onResourceReceived = function(C, response) {
//     utils.dump(response);
// };

function getLinks() {
    var links = document.querySelectorAll('tbody tr a');
    return Array.prototype.map.call(links, function(e) {
        return e.getAttribute('href');
    });
}

// function setCookies() {
//     var cookies = JSON.stringify( this.page.cookies )
//     cookies.map(function (cookie) {
//         if (cookie.name === "PHPSESSID" || cookie.name === "identifier") {
//             values[cookie.name] = cookie.value
//         }
//     });
//     return values;
// }

casper.start('https://www.allflicks.net', function() {
    this.waitForSelector('input[type="search"]');
    this.capture('before.png');
    this.sendKeys('input[type="search"]', 'glory', { reset: true }, { keepFocus: true });
});

casper.then(function() {
    this.sendKeys('input[type="search"]', casper.page.event.key.Enter, {keepFocus: true});
    this.waitForSelector('img[src="https://art-s.nflximg.net/19c5b/d7d6f44b7ca76eacd8739d627a0b34a4a4119c5b.jpg"]');
    this.capture('after.png');
});

casper.then(function() {

    casper.open('https://text-to-eat.herokuapp.com/cookies/create', {
        method: 'post',
        data:   { 'cookies': JSON.stringify(this.page.cookies) }
        },
        headers: {
            'Content-Type': 'application/json'
        }
    });
});

casper.run(function() {
    // echo results in some pretty fashion
    this.echo(links.length + ' links found:');
    this.echo(' - ' + links.join('\n - '));
    this.clear().exit();
});




chrome_binary = ENV.fetch('GOOGLE_CHROME_BIN', nil)

caps = Selenium::WebDriver::Remote::Capabilities.chrome(
  "chromeOptions" => {
    'binary' => chrome_binary,
    'args' => %w{headless no-sandbox disable-gpu}
  }
)

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(
     app,
     browser: :chrome,
     desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(chrome_opts)
  )
end

d = Selenium::WebDriver.for :chrome, desired_capabilities: caps

d.get("https://www.netflix.com/")
cookies = eval ENV["netflix_cookies"]
cookies.map { |hash| hash.map { |k, v| hash[k] = v.to_datetime if k == :expires } }
cookies.map { |cookie| d.manage.add_cookie(cookie) }
term = ""
d.get("https://www.netflix.com/search?q=#{term}")
d.find_elements(class: "profile-link").first.click
names = []
d.find_elements(css: "div").each { |div| names << div.attribute("aria-label") }
names.compact!
names.map! { |name| name.gsub(" ","").downcase }
matches.sort.reverse.first(3).map(&:second)
names.each { |name| results[ActiveRecord::Base.connection.execute("select similarity('#{name.gsub(" ","").gsub("'","").downcase}', '#{term.downcase.gsub(" ","")}')").getvalue(0,0)] = name }
results.sort_by { |k, v| -k }.map(&:second).first(3)

d.get("https://www.allflicks.net/")
d.find_element(xpath: "//*[@id='releases_filter']/label/input").send_keys("#{term}")
