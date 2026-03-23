@TestPOST
Feature: Création d'un projet Squash avec JWT

  Background:
    # Ton token JWT
    * header Authorization = 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMCIsInV1aWQiOiI1N2QwMzgyZi0wMDdkLTRlMzktYjIyMS05ZTU5YTIyYmRjZmMiLCJwZXJtaXNzaW9ucyI6IlJFQURfV1JJVEUiLCJpYXQiOjE3NzMxNTE4MzQsImV4cCI6MTgwNDYzNjgwMH0.3LFJPbM0lpuFWMG0Dcx_X-rdFRQKCUuZwtpe65e3och-MeiFe3cIr1s1qXh00yA4Gd3O157Lzoheu8nVggWSpA'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json; charset=UTF-8'

  Scenario: Créer une exigence Squash
    Given url 'https://demo.squashtest.org/squash/api/rest/latest/requirements'
    And request
    """
    {
  "_type": "requirement",
  "current_version": {
    "_type": "requirement-version",
    "name": "POC KARATE REQUIREMENT",
    "criticality": "MINOR",
    "category": { "code": "bug01" },
    "status": "WORK_IN_PROGRESS",
    "description": "Description test",
    "custom_fields": [
      { "code": "Labels", "value": ["priority::Low","status::To Do","type::Bug"] }
    ]
  },
  "parent": { "_type": "requirement-folder", "id": 6440 },
  "project": { "_type": "project", "id": 14 },
  "mode": "SYNCHRONIZED"
}
    """
    When method post
    Then status 201
    And print 'Exigence créé :', response


  Scenario: Modifier une ressource PATCH
    Given url 'https://demo.squashtest.org/squash/api/rest/latest/requirements/8489'
    And request
 """
  {
  "_type" : "requirement",
  "current_version" : {
    "name" : "POC KARATE"
   }
   }
  """
    When method patch
    Then status 200
    And print 'nom modifié:', response

  Scenario: Creer un requirement Folder
    Given url 'https://demo.squashtest.org/squash/api/rest/latest/requirement-folders'
    And request
 """
  {
  "_type" : "requirement-folder",
  "name" : "Requirement subfolder 1",
  "custom_fields" : [ {
    "code" : "cuf1",
    "value" : "Cuf1 Value"
  } ],
  "parent" : {
    "_type" : "requirement-folder",
    "id" : 6440
  }
}
  """
    When method patch
    Then status 201
    And print ' Dossier Exigence crée :', response

  Scenario: Delete un Requirement
    Given url 'https://demo.squashtest.org/squash/api/rest/latest/requirements/9030'
    When method delete
    Then status 204
    And print 'Exigence supprimé :', response