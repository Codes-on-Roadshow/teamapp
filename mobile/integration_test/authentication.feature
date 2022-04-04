Feature: Authentication
    Scenario: Login
        Given The app is running
        And I login
        Then I see {"Create Team"} text