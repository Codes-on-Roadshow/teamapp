Feature: Home
    Scenario: Home should show name
        Given the app is running
        Then I see {'Ranu WP'} text
    
    Scenario: Home should show email
        Given the app is running
        And I see {'ranu.wp@team.com'} text
