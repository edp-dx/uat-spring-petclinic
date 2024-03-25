Feature: Owner Management

  Background: 
    Given the PetClinic application is running at 'https://petclinic.example.com'

  Scenario: Initiate creation of a new owner
    When I send a GET request to '/owners/new'
    Then the response status should be 200
    And the response should contain the owner creation form

  Scenario Outline: Successfully create a new owner
    Given I have the following owner details
      | firstName | lastName | address      | city    | telephone |
      | <firstName> | <lastName> | <address> | <city> | <telephone> |
    When I send a POST request to '/owners/new' with the given details
    Then the response status should be 302
    And the response 'Location' header should be a valid owner URI

  Examples:
    | firstName | lastName | address       | city    | telephone |
    | John      | Doe      | 123 Main St.  | Anytown | 1234567890 |
    | Jane      | Roe      | 456 Elm St.   | Newtown | 9876543210 |

  Scenario: Attempt to create a new owner with missing required fields
    Given I have the following owner details with missing 'lastName'
      | firstName | address      | city    | telephone |
      | John      | 123 Main St. | Anytown | 1234567890 |
    When I send a POST request to '/owners/new' with the given details
    Then the response status should indicate a client error

  # Add cleanup scenarios if needed