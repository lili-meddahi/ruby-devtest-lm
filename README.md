# Dev Test - Dealership Inventory Manager

## Pre-reqs
- ruby 
- postgres

## To get your environment spun up
```bash
rails db:create && rails db:migrate && rails db:seed
```
```bash
bundle install
```

## Instructions
1. Fork this repo to your personal Github account. Sending a zip file or some other form of manual code sharing won't be accepted.
2. Write the necessary code per the `Requirements` section below, following standard git practices for version control.
3. Write Rspec tests validating the intended functionality explained below. We expect you to demo a working test suite during your panel interview.

## Requirements

Please develop a solution per the user story and acceptance criteria below. 

**Technical Requirement:** 

Any standard dropdown described below (such as Year, Make, Model) must be implemented as a separate model/class with its own table, rather than as a list or constant within the exsiting `Car` model. This ensures data normalization and allows for easy management of selectable options.

**User/System Requirements:** 
```gherkin
Feature: Car Structure Data Integrity
  As a user, 
  I want a system that will allow me to manage my vehicle inventory,
  so that I can keep track of my inventory more efficiently.

  Scenario: Creating a Successful Make
    Given I am creating a new Make
    When I fill in "BMW" in the Name field
    And I click "Submit"
    Then a new Make record should be created with a name "BMW"

  Scenario: Creating an Unsuccessful Make
    Given I am creating a new Make
    When I click "Submit"
    Then I should see an error message stating "Name can’t be blank"
    Then a new Make record should not be created

  Scenario: Creating a Successful Model
    Given I am creating a new Model
    Given Make "BMW" exists
    When I select "BMW" from the "Make" field
    When I enter "3 Series" into the "Name" field
    When I click "Submit"
    Then a new Model record should be created with a name of "3 Series" associated with "BMW" Make

  Scenario: Creating an Unsuccessful Model
    Given I am creating a new Model
    Given Make "BMW" exists
    When I select "BMW" from the "Make" field
    When I click "Submit"
    Then I should see an error message stating "Name can’t be blank"
    Then a new Model record should not be created

  Scenario: Creating a Successful Year
    Given I am creating a new Year
    Given Make "BMW" exists
    Given Model "3 Series" exists for "BMW" Make
    When I select "BMW" from the "Make" field
    When I select "3 Series" from the "Model" field
    When I enter in "2001" in the "Year" field
    When I click "Submit"
    Then a new Year record should be created with the year "2001" associated with "3 Series" Model and associated with "BMW" Make

  Scenario: Creating an Unsuccessful Year
    Given I am creating a new Year
    Given Make "BMW" exists
    Given Model "3 Series" exists for "BMW" Make
    When I select "BMW" from the "Make" field
    When I click "Submit"
    Then I should see an error message stating "Year can’t be blank"
    Then I should see an error message stating "Model can’t be blank"
    Then a new Model record should not be created

  Scenario: Car records reference only valid combinations - Make/Model
    Given I am creating a new Car
    Given Make "BMW" exists
    Given Make "Audi" exists
    Given Model "3 Series" exists for "BMW" Make
    Given Model "S3" exists for "Audi" Make
    And I selected "BMW" from "Make"
    Then I should see "3 Series" Model options
    Then I should not see "S3" Model options

  Scenario: Car records reference only valid combinations - Model/Year
    Given I am creating a new Car
    Given Make "BMW" exists
    Given Make "Audi" exists
    Given Model "3 Series" exists for "BMW" Make
    Given Model "S3" exists for "Audi" Make
    Given Year "2022" exists for "3 Series" Model and "BMW" Make
    Given Year "2019" exists for "S3" Model and "Audi" Make
    When I select "BMW" from Make
    And I selected "3 Series" from Model
    Then I should see "2022" Year options
    And I should not see "2019" Year options

  Scenario: Car record created successfully
    Given I am creating a new Car
    And Make "BMW" exists
    And Model "3 Series" exists for "BMW" Make
    And Year "2022" exists for "3 Series" Model and "BMW" Make
    When I select "BMW" from Make
    And I select "3 Series" from Model
    And I selected "2022" from Year
    When I click "Submit"
    Then a new Car record should be created successfully

  Scenario: Car record created with error
    Given I am creating a new Car
    And Make "BMW" exists
    And Model "3 Series" exists for "BMW" Make
    And Year "2022" exists for "3 Series" Model and "BMW" Make
    When I select "BMW" from Make
    When I click "Submit"
    Then I should see an error message stating "Model can’t be blank"
    Then I should see an error message stating "Year can’t be blank"
    Then a new Car should not be created
```
---
