function fn() {

  var config = {};

  // Headers Squash TM
  config.headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    Accept: 'application/json',
    Authorization: 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMCIsInV1aWQiOiI1N2QwMzgyZi0wMDdkLTRlMzktYjIyMS05ZTU5YTIyYmRjZmMiLCJwZXJtaXNzaW9ucyI6IlJFQURfV1JJVEUiLCJpYXQiOjE3NzMxNTE4MzQsImV4cCI6MTgwNDYzNjgwMH0.3LFJPbM0lpuFWMG0Dcx_X-rdFRQKCUuZwtpe65e3och-MeiFe3cIr1s1qXh00yA4Gd3O157Lzoheu8nVggWSpA'
  };

  // Endpoints Squash TM
  config.endpoints = {
    listRequirements: '/projects/14/requirements',
    getRequirement: '/requirements/9030',
    listProjects: '/projects',
    listUsers: '/users',
    listTestCases: '/test-cases',
    bugs:'/issues',
    idtestcase:'/5055',
    steps:'/test-steps',
    idproject: '/projects/12'



  };

  // Paramètres par défaut
  config.defaultParams = {
    page: 0,
    size: 50,
    sort: 'id,desc',
    fields:'name,reference,script,charter,session_duration',
    expectedstatute: 200,


  };

  // Environnement
  var env = karate.env;
  if (!env) { env = 'dev'; }

  // URLs centralisées
  if (env == 'dev') {
    config.baseUrl = 'https://demo.squashtest.org/squash/api/rest/latest';
  }
  else if (env == 'qa') {
    config.baseUrl = 'https://qa.squashtest.org/squash/api/rest/latest';
  }
  else if (env == 'prod') {
    config.baseUrl = 'https://prod.squashtest.org/squash/api/rest/latest';
  }

  return config;
}