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
      "_type" : "requirement",
      "current_version" : {
        "_type" : "requirement-version",
        "name" : "new age",
        "criticality" : "MINOR",
        "category" : {
          "code" : "CAT_USER_STORY"
        },
        "status" : "UNDER_REVIEW",
        "description" : "<p>leave a comment please</p>",
        "custom_fields" : [ {
          "code" : "cuf_txt_note",
          "value" : "Star Trek style welcomed but not mandatory"
        }, {
          "code" : "cuf_tags_see_also",
          "value" : [ "smart home", "sensors", "hand gesture" ]
        } ]
      },
      "parent" : {
        "_type" : "requirement",
        "id" : 9030
      }
    }
    """
    When method post
    Then status 201
    And print 'Projet créé :', response