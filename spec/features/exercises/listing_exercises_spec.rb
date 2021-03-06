require 'rails_helper'
RSpec.feature 'Listing exercises' do
  before do 
       @john = User.create!(first_name: "John",
                         last_name: "Doe",
                         email: "john@example.com",
                         password: "password")
                         
       @sarah = User.create!(first_name:"Sarah",
                         last_name:"Connor",
                         email: "sarah@example.com",
                         password: "password")
    
     
     @e1 = @john.exercises.create(duration_in_minutes:20,
                                  workout: "My bodybuilding activity",
                                  workout_date: Date.today)
                                  
     @e2 = @john.exercises.create(duration_in_minutes:55,
                                  workout: "Weight lifting",
                                  workout_date: 2.days.ago)  
    
    login_as(@john)
    
    @following = Friendship.create(user: @john, friend: @sarah) 
    
    # @e3 = @john.exercises.create(duration_in_minutes:35,
    #                               workout: "Treadmill",
    #                               workout_date: 8.days.ago)                               
   end
   scenario "shows user's workout for last 7 days" do 
     visit '/'
     click_link 'My Lounge'
     
     expect(page).to have_content(@e1.duration_in_minutes)
     expect(page).to have_content(@e1.workout)
     expect(page).to have_content(@e1.workout_date)
     
     expect(page).to have_content(@e2.duration_in_minutes)
     expect(page).to have_content(@e2.workout)
     expect(page).to have_content(@e2.workout_date)
     
    # expect(page).not_to have_content(@e3.duration_in_minutes)
    # expect(page).not_to have_content(@e3.workout)
    # expect(page).not_to have_content(@e3.workout_date)
     
     
   end
   
   scenario "shows no exercises if none created" do
      @john.exercises.delete_all
      
      visit '/'
      click_link "My Lounge"
      
      expect(page).to have_content "No Workouts Yet"
   end
   
   scenario "shows a list of user's friends" do
     
     visit '/'
     click_link "My Lounge"
     
     expect(page).to have_content("My Friends")
     expect(page).to have_link(@sarah.full_name)
     expect(page).to have_link("Unfollow")
   end
  
end