feature 'Testing infrastructure' do
  scenario 'Can run app and check page content' do
    visit('/')
    expect(page).to have_content 'Testing infrastructure working!'
  end
end
feature 'Player names' do
  scenario 'filled in and displayed on screen' do
    sign_in_and_play()
    expect(page).to have_content "Dave's monster"
  end
end
feature 'Player HP' do
  scenario 'is visible' do
    sign_in_and_play()
    expect(page).to have_content "50/50"
  end
end
feature 'Player turn' do
  scenario 'player1\'s turn' do
    sign_in_and_play()
    expect(page).to have_content "Dave's turn"
  end
end
