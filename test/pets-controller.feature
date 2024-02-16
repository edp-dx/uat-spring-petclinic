Feature: Pets management

  Scenario: List all pets
    Given the pet clinic is online
    When a user requests a list of pets
    Then the system should return all available pets

  Scenario: Get a pet by ID
    Given the pet clinic is online
    And a pet with ID '1' exists
    When a user requests details for pet with ID '1'
    Then the system should return details of the pet with ID '1'