Feature: Book API Operations

Scenario Outline: Verify if title, Author, and year is being Successfully added using ADD bookAPI
@book @smoke @crud
   This feature tests the CRUD operations for managing books via the Book API.

  @create @positive
  Scenario: Create a new book
    Given a new book with title "<title>", author "<author>", and year "<year>"
    When I send a POST request to create the book
    Then the book should be created with status code 201

  @read @positive @regression
  Scenario: Retrieve the created book by ID
    Given a new book with title "<title>", author "<author>", and year "<year>"
    When I send a POST request to create the book
    Then the book should be created with status code 201
    When I retrieve the book by ID
    Then the response should contain the title "The Pragmatic Programmer"

  @update @positive @regression
  Scenario: Update the book title
    Given a new book with title "<title>", author "<author>", and year "<year>"
    When I send a POST request to create the book
    Then the book should be created with status code 201
    When I update the book title to "Refactoring (2nd Edition)"
    Then the book should be updated with status code 200
    When I retrieve the book by ID
    Then the response should contain the title "Refactoring (2nd Edition)"

  @delete @positive @regression
  Scenario: Delete an existing book
    Given a new book with title "<title>", author "<author>", and year "<year>"
    When I send a POST request to create the book
    Then the book should be created with status code 201
    When I delete the book by ID
    Then the book should be deleted with status code 204

  @read @negative
  Scenario: Fetch a non-existent book by ID
    When I try to fetch a non-existent book ID
    Then the book should be deleted with status code 404
    
  @create @negative @regression
  Scenario: Create book without prviding author and year 
    Given a new book with title "Java Programming"
    When I send a POST request to create the book
    Then the book should be not be created and response status code 400 
    When Error message has been show up as "Author and year fields required to create book"
    Then the response should contain the message "Error Message"
    
  @create @negative @regression
  Scenario: Create book without leave title and year blank 
    Given a new book with title "" , author "Ken Arnold", and year " "
    When I send a POST request to create te book
    Then the book should be not be created and response status code 400 
    When Error message has been show up as "title and year fields required for create book"
    Then the response should contain the message "Error Message"


Examples:
		|         title           |       author         |   year   |
		|Clean Code               | Robert C. Martin     | 2008     |
		|The Pragmatic Programmer | Andrew Hunt          | 1999     | 
		|Refactoring              | Martin Fowler        | 1999     |   
		|Domain-Driven Design     | Eric Evans           | 2003     |
