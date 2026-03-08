Feature: Calculator Addition

  Background:
    * url baseUrl
    * configure headers = headers
    * header SOAPAction = endpoints.add

  Scenario Outline: Tester toutes les variations de l'addition et gérer les erreurs

    * def a = <intA>
    * def b = <intB>
    * def expected = '<Result>'

  # Vérification des erreurs avant appel SOAP
    * def preCheck =
  """
  function(a,b){
    if (isNaN(a) || isNaN(b)) return { error: 'Format invalide' }
    return null
  }
  """

    * def check = preCheck(a,b)

  # Si erreur attendue
    * if (check && expected == 'ERROR') karate.match(check.error, 'Format invalide')

  # Si erreur -> arrêter le scénario
    * if (check) karate.abort()

    Given request
    """
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
       <Add xmlns="http://tempuri.org/">
         <intA>#{a}</intA>
         <intB>#{b}</intB>
       </Add>
      </soap:Body>
    </soap:Envelope>
    """

    When method post
    Then status 200

  # Extraction du résultat SOAP
    * def addResult = response/soap:Envelope/soap:Body/AddResponse/AddResult/text()
    * def resultValue = addResult * 1

    * print 'Résultat obtenu:', resultValue

  # Vérification du résultat attendu
    * match resultValue == expected * 1

    Examples:
      | intA | intB | Result | commentaire |
      | 5    | 3    | 8      | addition normale |
      | 10   | 20   | 30     | addition classique |
      | 0    | 7    | 7      | addition avec zéro |
      | -5   | 10   | 5      | nombre négatif |
      | 10   | -3   | 7      | nombre négatif |
      | -5   | -5   | -10    | négatif + négatif |
      | 'abc'| 5    | ERROR  | mauvais format intA |
      | 5    | 'xyz'| ERROR  | mauvais format intB |