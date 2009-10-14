Feature: Follow injour orders
  In order to trigger tasks by changing my status message
  As an injour user
  I want orders in my status message to be followed
    
  Scenario: Status message contains a new order
    Given a servant is listening for orders from injour
    When an injour status is changed to contain an order
    Then the order is followed