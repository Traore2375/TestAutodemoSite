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
        "name": "User can save password that contains only lowercase letters",
        "criticality": "MINOR",
        "category": { "code": "bug01" },
        "status": "WORK_IN_PROGRESS",
        "description": "Test Case : Password set up check",
        "custom_fields": [
          { "code": "Labels", "value": ["priority::Low","status::To Do","type::Bug"] }
        ]
      },
      "parent": { "_type": "requirement-folder", "id": 6440 },
      "project": { "_type": "project", "id": 14 },
      "mode": "SYNCHRONIZED",
      "remote_req_id": "171722906",
      "remote_req_url": "https://gitlab.com/henixdevelopment/demo/public-demo/sandbox-xsquash4gitlab-en/-/issues/25",
      "remote_req_perimeter_status": "IN_CURRENT_PERIMETER"
    }
    """
    When method post
    Then status 201
    And print 'Projet créé :', response


  Scenario: Modifier une ressource PATCH
    Given url 'https://demo.squashtest.org/squash/api/rest/latest/requirements/9030/convert'
    And request
 """
  {
    "current_version": {

      "name": "nouveau nom",

    }
  }
  """
    When method patch
    Then status 201
    And print 'nom modifié:', response