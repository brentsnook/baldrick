Feature: Follow RSS orders

  As a person interested in an RSS feed
  I want new items to be followed as orders
  So that tasks will be performed according to the content of each item
    
  Scenario: RSS feed item contains a new order

    Given a servant is listening for orders from RSS

    When a new item appears in the feed containing an order

    Then the order is followed