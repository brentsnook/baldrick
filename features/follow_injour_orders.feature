Feature: Follow injour orders

  As a injour user
  I want orders in my status message to be followed
  So that I can trigger jobs by changing my status message
    
  Scenario: Status message contains a new order

    Given that a servant is listening for orders

    When an injour status is changed to one that contains an order

    Then the order is followed