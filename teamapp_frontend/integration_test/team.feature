Feature: Team
    Scenario: Create a new team
        Given the app is running
        And I tap {"Create Team"} text
        When I enter {"Death Note"} into {0} input field
        And I tap {"Create Team"} text
        Then I see {"Invite your team using this code"} text
        And I see {"Death Note"} text