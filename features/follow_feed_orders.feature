Feature: Follow feed orders

  As a person interested in a web feed
  I want new items to be followed as orders
  So that tasks will be performed according to the content of each item
    
  Scenario: Feed item contains a new order

    Given a servant is listening for orders from a feed

    When a new item appears in the feed containing an order

    Then the order is followed