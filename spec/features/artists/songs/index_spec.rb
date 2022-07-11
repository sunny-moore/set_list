require 'rails_helper'
# As a user
# When I visit an Artist's Songs index
# Then I see the titles of all that Artist's Songs
# And I see that each title is a link to the songs show page

RSpec.describe 'Artists songs index' do
  before :each do
    @prince = Artist.create!(name: 'Prince')
    @purple = @prince.songs.create!(title: 'Purple Rain', length: 845, play_count: 8599)
    @beret = @prince.songs.create!(title: 'Raspberry Beret', length: 664, play_count: 2300)
    @other_song = @prince.songs.create!(title: 'Another Prince Song', length: 1, play_count: 99)
  end
  it 'shows all of the titles of songs for the artist' do
    visit "/artists/#{@prince.id}/songs"

    expect(page).to have_content(@purple.title)
    expect(page).to have_content(@beret.title)
  end

  it 'links to each songs show page' do
    visit "/artists/#{@prince.id}/songs"

    click_on @purple.title 

    expect(current_path).to eq("/songs/#{@purple.id}")
  end

  it 'shows the average song length for the artist' do
    visit "/artists/#{@prince.id}/songs"

    expect(page).to have_content("Average Song Length for Prince: 503")
  end
end