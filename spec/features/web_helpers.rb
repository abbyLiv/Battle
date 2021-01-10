def sign_in_and_play(player1="Dave", player2="Mittens")
  visit('/names')
  fill_in :player1, with: "Dave"
  fill_in :player2, with: "Mittens"
  click_button 'Submit'
end
