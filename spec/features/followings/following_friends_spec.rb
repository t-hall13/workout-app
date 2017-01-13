require 'rails_helper'
RSpec.feature "Following Friends" do
  
 before do
  @john = User.create(first_name: "John",
                       last_name: "Doe",
                       email: "john@example.com",
                       password: "password")
                       
  @sarah = User.create(first_name: "Belinda",
                       last_name: "Rae",
                       email: "sarah@example.com",
                       password: "password1")
                       
  login_as(@john)                     
  end
  
  scenario "if signed in" do
    visit '/'
    
    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@sarah.full_name)
    
    href = "/friendships?friend_id=#{@john.id}"
    expect(page).not_to have_link("Follow", :href => href)
    
    link = "a[href='/friendships?friend_id=#{@sarah.id}']"
    find(link).click
    
    href = "/friendships?friend_id=#{@sarah.id}"
    expect(page).not_to have_link("Follow", :href => href)
  end
end