Feature: Pet Management

  Background: 
    Given the PetClinic application is running at 'https://petclinic.example.com'

  Scenario Outline: Initiate creation of a new pet
    Given an owner with ID <ownerId> exists
    When I send a GET request to '/owners/{ownerId}/pets/new'
    Then the response status should be 200
    And the response should contain the pet creation form

  Scenario Outline: Successfully create a new pet
    Given an owner with ID <ownerId> exists
    And I have the following pet details
      | name    | birthDate  | type        |
      | <name>  | <birthDate>| <type>      |
    When I send a POST request to '/owners/{ownerId}/pets/new' with the given details
    Then the response status should be 302
    And the response 'Location' header should be '/owners/{ownerId}'

  Examples:
    | ownerId | name      | birthDate  | type      |
    | 1       | Bella     | 2021-08-15 | Dog       |
    | 2       | Whiskers  | 2020-11-01 | Cat       |

  Scenario: Attempt to create a new pet with missing required fields
    Given an owner with ID 1 exists
    When I send a POST request to '/owners/1/pets/new' with missing 'name'
    Then the response status should indicate a client error

  # Add cleanup scenarios if needed