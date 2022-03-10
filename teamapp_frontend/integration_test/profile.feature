Feature: Profile

    Scenario: Profile page should have name and email
        Given the app is running
        Then I see {'Ranu WP'} text
        And I see {'ranu.wp@team.com'} text
        
