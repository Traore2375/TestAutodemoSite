@TestGET
Feature: Squash TM via API

  Background:
    * def config = callonce read('classpath:config/config-squash.js')
    * url config.baseUrl
    * headers config.headers

  Scenario: Lister la liste des projets
    Given path config.endpoints.listProjects
    And param page = config.defaultParams.page
    And param size = config.defaultParams.size
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And print ' ------------Voici la liste des projets ----------',response

  Scenario: Recuperer un projet avec son ID
    Given path config.endpoints.idproject
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And print ' ---------Le projet est :  ----------',response

  Scenario: Lister toutes les exigences
    Given path config.endpoints.listRequirements
    And param page = config.defaultParams.page
    And param size = config.defaultParams.size
    And param sort = config.defaultParams.sort
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And print ' ------------Voici la listes des exigences du projet ----------',response

  Scenario: Recuperer une exigence avec son ID
    Given path config.endpoints.getRequirement
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And print ' --------Exigence :  ------',response

  Scenario: Lister l'ensemble des cas de test
    Given path config.endpoints.listTestCases
    And param page = config.defaultParams.page
    And param size = config.defaultParams.size
    And param fields = config.defaultParams.fields
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And print '------Liste des cas de test-------- :', response

  Scenario: Recuperer un cas de test avec son ID
    Given path config.endpoints.listTestCases
    And path idtestcases = config.endpoints.idtestcase
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And print '-----------Le cas de test ------:', response


  Scenario: Lister les bugs liée à un cas de test
    Given path config.endpoints.listTestCases
    And path idtestcases = config.endpoints.idtestcase
    And path bugs = config.endpoints.bugs
    And param page = config.defaultParams.page
    And param size = config.defaultParams.size
    And param fields = config.defaultParams.fields
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And print '---------Liste des bugs ------------:', response

  Scenario: Recuperer les steps du test
    Given path config.endpoints.steps
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And print '---------Le step de test ------:', response


  Scenario: Lister la liste des utilisateurs
    Given path config.endpoints.listUsers
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    * print 'Liste des utilisateurs:', response
    And print 'Erreur 403: Interdire de voir la liste des Utilisateur' + response.status
