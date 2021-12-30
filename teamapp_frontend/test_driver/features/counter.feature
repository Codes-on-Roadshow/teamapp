Feature: Counter
    As a user
    I want to tap the plus button
    So that I can see the counter increment

    Scenario: Counter increases when the button is pressed
        Given The counter is "0"
        When I tap the "Increment" button 10 times
        Then The counter is "10"