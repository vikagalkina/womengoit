require 'capybara/rspec'
require 'webdrivers'

feature 'WomenGoIT test', type: :feature do

  Capybara.app_host = 'https://womengoit.com/'
  Capybara.run_server = false
  Capybara.default_driver = :selenium_chrome

  scenario 'Visit WomenGoIt' do
    visit '/'
    expect(page.title).to have_content('Womengoit')
    expect(page).to have_content("Женщины в IT")

    expect(page).to_not have_content("ОТПРАВИТЬ ЗАЯВКУ")

    find(:xpath, "/html/body/main/div[1]/div/button/a").click
    expect(page).to have_content("ОТПРАВИТЬ ЗАЯВКУ")
    sleep(1)

    find('#popup1 > div > div > form > input[name="senderName"]').set('Виктория')
    sleep(1)
    find('#popup1 > div > div > form > input[name="senderEmail"]').set('testuser@mailforspam.com')
    sleep(1)
    find('#popup1 > div > div > form > input[name="phoneNumber"]').set('123456789')
    sleep(1)
    find('#popup1 > div > div > form > button').click
    sleep(1)


    expect(page).to have_content("Наш менеджер свяжеться с тобой на протяжении 15-ти минут")
  end
end