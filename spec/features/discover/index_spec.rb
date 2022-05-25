# frozen_string_literal: true

require 'rails_helper'

describe 'Discover Movies' do
  before do
    @user1 = User.create!(name: 'John', email: 'john.hennerich@gmail.com', password: 'john', password_confirmation: 'john')
    @user2 = User.create!(name: 'Brylan', email: 'brylan.gannon112@gmail.com', password: 'brylan', password_confirmation: 'brylan')
    visit '/login'
    fill_in :email, with: 'john.hennerich@gmail.com'
    fill_in :password, with: 'john'
    click_button 'Login'
    visit "dashboard/discover"
  end

  it 'Displays a header' do
    expect(page).to have_content('Discover Movies')
  end

  it 'displays a top movies button that routes to the discover page' do
    click_button 'Top Rated Movies'

#    expect(current_path).to eq("/users/#{@user1.id}/movies")
    expect(current_path).to eq("/dashboard/movies")
  end

  it 'displays a search bar to find movies by keyword' do
    fill_in :query, with: 'Mad'
    click_button 'Search by Title'

    expect(current_path).to eq("/dashboard/movies")
  end
end
