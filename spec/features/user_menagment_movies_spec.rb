feature 'User ', :devise do
  scenario 'user can create movies with genres' do
    user = create(:user, email: 'example@o2.pl', password: 'password', name: 'AWSOME_USER')
    action = create(:genre, title: 'Action')
    create(:genre, title: 'Animation')

    signin(user.email, 'password')

    visit new_movie_path

    fill_in :movie_title, with: 'Animatrix'
    fill_in :movie_description, with: 'Animatrix is a 2003 American–Japanese'\
                                    ' anthology anime film produced by the Wachowskis'

    check 'Action'
    click_on 'Create'

    expect(page).to have_content('Animatrix Action  AWSOME_USER')
  end

  scenario 'view all movies and menage them' do
    another_user = create(:user, email: 'new_user@o2.pl', password: 'password', name: 'NEWUSER')
    current_user = create(:user, email: 'example@o2.pl', password: 'password', name: 'AWSOME_USER')
    action_genre = create(:genre, title: 'action', user: current_user)
    animation_genre = create(:genre, title: 'animation', user: another_user)

    create(:movie,
           description: 'Animatrix is a 2003 American–Japanese anthology anime film produced by the Wachowskis',
           genres: [action_genre, animation_genre],
           user_id: current_user.id,
           title: 'Animatrix')
    create(:movie,
           description: 'Lethal Weapon is a 1987 American buddy cop action film directed by Richard Donner,',
           genres: [action_genre],
           user_id: another_user.id,
           title: 'Lethal Weapon')

    signin(current_user.email, 'password')

    visit root_path

    expect(page).to have_content('Title Genre User')
    expect(page).to have_content('Animatrix Action Animation AWSOME_USER')
    expect(page).to have_content('Lethal Weapon Action NEWUSER')

    click_on 'Animation'

    expect(page).to have_content('Animatrix Action Animation')
    expect(page).not_to have_content('Lethal Weapon Action')

    click_on 'Reset'

    expect(page).to have_content('Animatrix Action Animation AWSOME_USER')
    expect(page).to have_content('Lethal Weapon Action NEWUSER')

    click_on 'AWSOME_USER'

    expect(page).to have_content('Animatrix Action Animation AWSOME_USER')
    expect(page).not_to have_content('Lethal Weapon Action NEWUSER')
  end
end
