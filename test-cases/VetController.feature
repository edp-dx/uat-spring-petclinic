Feature: Vet Management

  Background: 
    Given the PetClinic application is running at 'https://petclinic.example.com'

  Scenario: List all vets
    When I send a GET request to '/vets'
    Then the response status should be 200
    And the response should contain a list of vets

  Scenario Outline: Show vet list page with pagination
    When I send a GET request to '/vets.html' with the query parameter 'page' set to <page>
    Then the response status should be 200
    And the response should contain a vet list page for page number <page>

  Examples:
    | page |
    | 1    |
    | 2    |
    | 3    |

  # Additional scenarios can be added for error cases or specific vet details