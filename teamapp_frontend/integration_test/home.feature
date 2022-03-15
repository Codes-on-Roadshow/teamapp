Feature: Home
    Scenario: should show name
        Given the app is running
        Then I see {'Ranu WP'} text
    
    Scenario: should show email
        Given the app is running
        And I see {'ranu.wp@team.com'} text
