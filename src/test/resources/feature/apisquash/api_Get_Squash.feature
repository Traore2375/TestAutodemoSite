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
    ## Verification du nombre elements et nombre projets
    * def nbProjects = response._embedded.projects.length
    And print 'Nombre de projets :', nbProjects
    And match nbProjects == response.page.totalElements
    ## ------------Liste des projects dans SQUASH --------------
    And print ' ----Voici la liste des projets : ------',response

    ## ------------Structure projects dans SQUASH --------------
    And print '----- Structure du projet----',response._embedded.projects

    And  match each response._embedded.projects ==
      """
      {
        _type: 'project',
        id: '#number',
        name: '#string',
        _links: '#object'
      }
      """

  Scenario: Recuperer un projet avec son ID
    Given path config.endpoints.idproject
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And print '----Le projet est : -------',response


  Scenario: Lister toutes les exigences
    Given path config.endpoints.listRequirements
    And param page = config.defaultParams.page
    And param size = config.defaultParams.size
    And param sort = config.defaultParams.sort
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And print ' ------------Voici la listes des exigences du projet ----------',response
    And  match response._type == 'requirement'
    And  match response ==
      """
      {
        _type: 'requirement',
        id: '#number',
        name: '#string',
        project: '#object',
        _links: '#string'
      }
      """


  Scenario: Recuperer une exigence avec son ID
    Given path config.endpoints.getRequirement
    When method GET
    Then match  responseStatus ==config.defaultParams.expectedstatute
    And match response.name == config.defaultParams.nametestcases
    And print response.name
    And match response._type == 'requirement'
    And print ' --------Exigence :  ------',response
    ## Verifier le project associé avec son  nom
    And match response.project.name == '04 - Sandbox Xsquash4GitLab EN'

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
