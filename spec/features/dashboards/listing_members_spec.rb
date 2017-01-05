require 'rails_helper'
RSpec.feature "Listing members" do
  before do
    @john = User.create(first_name: "John",
                         last_name: "Doe",
                         email: "john@example.com",
                         password: "password")
                         
     @sarah = User.create(first_name: "Sarah",
                         last_name: "Connor",
                         email: "sarah@example.com",
                         password: "password1")                     
  end
  
  scenario "shows a list of registered users" do
    visit '/'
    
    expect(page).to have_content("Members")
    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@sarah.full_name)
    
  end
end