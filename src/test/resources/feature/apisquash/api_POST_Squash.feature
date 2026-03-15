@TestPOST
Feature: Création d'un projet Squash avec JWT

  Background:
  # Ton token JWT
    * header Authorization = 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMCIsInV1aWQiOiI1N2QwMzgyZi0wMDdkLTRlMzktYjIyMS05ZTU5YTIyYmRjZmMiLCJwZXJtaXNzaW9ucyI6IlJFQURfV1JJVEUiLCJpYXQiOjE3NzMxNTE4MzQsImV4cCI6MTgwNDYzNjgwMH0.3LFJPbM0lpuFWMG0Dcx_X-rdFRQKCUuZwtpe65e3och-MeiFe3cIr1s1qXh00yA4Gd3O157Lzoheu8nVggWSpA'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json; charset=UTF-8'

  Scenario: Créer un projet Squash
    Given url 'https://demo.squashtest.org/squash/api/rest/latest/requirements'

    And request
    """
      {
    "name": "Exigence API Karate",
    "description": "Creation automatique via Karate",
    "parent": {
      "id": 9030,
      "type": "requirement-folder"
    }
  }
    """
    When method post
    Then status 201
    And print 'Projet créé :', response