@TestGET
Feature: Squash TM via API

  Background:
    * def config = callonce read('classpath:config/config-squash.js')
    * url config.baseUrl
    * headers config.headers

  Scenario: Lister toutes les exigences
    Given path config.endpoints.listRequirements
    And param page = config.defaultParams.page
    And param size = config.defaultParams.size
    And param sort = config.defaultParams.sort
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
     And print ' ------------Voici la listes des exigences du projet ----------',response

  Scenario: Lister la liste des projets
    Given path config.endpoints.listProjects
    And param page = config.defaultParams.page
    And param size = config.defaultParams.size
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And print ' ------------Voici la liste des projets ----------',response


  Scenario: Lister les cas de test
    Given path config.endpoints.listTestCases
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And print 'Liste des utilisateurs:', response


  Scenario: Lister la liste des utilisateurs
    Given path config.endpoints.listUsers
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    * print 'Liste des utilisateurs:', response
    And print 'Erreur 403: Interdire de voir la liste des Utilisateur' + response.status
