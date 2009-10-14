Feature: Follow feed orders
  In order to allow tasks to be triggered from RSS
  As a person interested in a web feed
  I want new RSS items to be followed as orders
    
  Scenario: Feed item contains a new order
    Given a servant is listening for orders from a feed
    When a new item appears in the feed containing an order
    Then the order is followed