Feature: Team
    Scenario: Create a new team
        Given the app is running
        And I tap {"Create Team"} text
        When I enter {"Team"} into {0} input field
        Then I see {"Invite your team using this code"} text
        And I see {"Team"} text