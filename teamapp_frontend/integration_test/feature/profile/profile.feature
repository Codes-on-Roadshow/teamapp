Feature: Profile
    Scenario: Profile should show name, email, and avatar
        Given the app is running
        Then I see {'Ranu WP'} text
        And I see {'ranu.wp@team.com'} text
        And I see {'avatar-image'} image
    
