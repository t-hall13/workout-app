require 'rails_helper'

RSpec.feature 'Deleting exercises' do
  
  before do 
       @owner = User.create!(first_name: "John",
                             last_name: "Doe",
                             email: "john@example.com",
                             password: "password")
       @owner_exer = @owner.exercises.create!(duration_in_minutes: 48,
                                                  workout: "Slippin and Slidin",
                                                  workout_date: Date.today)
     login_as(@owner)
     end
     
     scenario do
        visit '/'
     click_link 'My Lounge'
     path = "/users/#{@owner.id}/exercises/#{@owner_exer.id}"
     link = "//a[contains(@href,\'#{path}\') and .//text()='Destroy']"
     find(:xpath, link).click
     
     expect(page).to have_content("Exercise has been deleted")
       
     end
    
end