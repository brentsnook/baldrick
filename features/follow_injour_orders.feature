Feature: Follow injour orders

  As an injour user
  I want orders in my status message to be followed
  So that I can cause tasks performed by changing my status message
    
  Scenario: Status message contains a new order

    Given a servant is listening for orders from injour

    When an injour status is changed to contain an order

    Then the order is followed