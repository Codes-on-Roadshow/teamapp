Feature: Profile
    Scenario: should show name, email, and avatar
        Given the app is running
        When I tap {Icons.person} icon
        Then I see {'Ranu WP'} text
        And I see {'ranu.wp@team.com'} text
        And I see {'avatar-image'} image
        And I see {'Sign Out'} text
    
