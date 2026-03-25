@TestPOST
Feature: Création d'un projet Squash avec JWT

  Background:
    # Ton token JWT
    * header Authorization = 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMCIsInV1aWQiOiI1N2QwMzgyZi0wMDdkLTRlMzktYjIyMS05ZTU5YTIyYmRjZmMiLCJwZXJtaXNzaW9ucyI6IlJFQURfV1JJVEUiLCJpYXQiOjE3NzMxNTE4MzQsImV4cCI6MTgwNDYzNjgwMH0.3LFJPbM0lpuFWMG0Dcx_X-rdFRQKCUuZwtpe65e3och-MeiFe3cIr1s1qXh00yA4Gd3O157Lzoheu8nVggWSpA'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json; charset=UTF-8'




  Scenario: Creer un requirement Folder
    Given url 'https://demo.squashtest.org/squash/api/rest/latest/requirement-folders'
    And request
 """
  {
  "_type" : "requirement-folder",
  "name" : "Requirement POC KARATE DEMO",
  "parent" : {
    "_type" : "requirement-folder",
    "id" : 6440
  }
}
  """
    When method post
    Then status 201
    And print ' Dossier Exigence crée :', response

  Scenario: Créer une exigence Squash
    Given url 'https://demo.squashtest.org/squash/api/rest/latest/requirements'
    And request
    """
 {
     "_type": "requirement" ,
     "parent": {
         "_type": "requirement-folder",
         "id": 6440},
     "current_version": {
         "name": "Exigence Modele POC BDD",
         "criticality": "MINOR",
         "category": {
             "code": "story01"
         },
         "status": "WORK_IN_PROGRESS",
         "description": "Nouvelle exigence pour creer un POC ALD pour un client final "
     }
 }
    """
    When method post
    Then status 201
    And print 'Exigence créé :', response

  Scenario: Modifier une une exigence PATCH
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

  Scenario: Créer un cas de test
    Given url 'https://demo.squashtest.org/squash/api/rest/latest/test-cases'
    And request
    """
      {
        "_type" : "test-case",
        "name" : "karate user stories cases ",
        "parent" : {
          "_type" : "project",
          "id" : 14
        }
        }

    """
    When method post
    Then status 201
    And print ' cas de test crée :', response


  Scenario: Liée un cas de test à une exigence
    Given url 'https://demo.squashtest.org/squash/api/rest/latest/test-cases/8155/coverages/9576'
    And request
    """
      {
        "_type" : "test-case",
        "name" : "cas de test 9 poc karate demo ",
        "parent" : {
          "_type" : "project",
          "id" : 14
        }
        }

    """
    When method post
    Then status 200
    And print ' cas de test crée :', response


  Scenario: Delete un Requirement
    Given url 'https://demo.squashtest.org/squash/api/rest/latest/requirements/9030'
    When method delete
    Then status 204
    And print 'Exigence supprimé :', response