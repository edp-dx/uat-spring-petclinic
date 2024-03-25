Feature: Visit Management

  Background: 
    Given the PetClinic application is running at 'https://petclinic.example.com'

  Scenario Outline: Initiate creation of a new visit
    Given an owner with ID <ownerId> exists
    And a pet with ID <petId> belonging to the owner exists
    When I send a GET request to '/owners/{ownerId}/pets/{petId}/visits/new'
    Then the response status should be 200
    And the response should contain the visit creation form

  Scenario Outline: Successfully create a new visit
    Given an owner with ID <ownerId> exists
    And a pet with ID <petId> belonging to the owner exists
    And I have the following visit details
      | date       | description       |
      | <date>     | <description>     |
    When I send a POST request to '/owners/{ownerId}/pets/{petId}/visits/new' with the given details
    Then the response status should be 302
    And the response 'Location' header should be '/owners/{ownerId}'

  Examples:
    | ownerId | petId | date       | description         |
    | 1       | 2     | 2023-04-12 | Annual vaccination  |
    | 3       | 4     | 2023-05-19 | General checkup     |

  Scenario: Attempt to create a new visit with missing required fields
    Given an owner with ID 1 exists
    And a pet with ID 2 belonging to the owner exists
    When I send a POST request to '/owners/1/pets/2/visits/new' with missing 'description'
    Then the response status should indicate a client error

  # Add cleanup scenarios if needed