Feature: Profile
    Scenario: should show name, email, avatar and sign out
        Given the app is running
        And I login
        When I tap {Icons.person} icon
        Then I see {'Ranu WP'} text
        And I see {'ranuwp@test.teamapp.com'} text
        And I see {'avatar-image'} image
        And I see {'Sign Out'} text