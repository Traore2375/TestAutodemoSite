Feature: Calculator Division

  Background:
    * url baseUrl
    * configure headers = headers
    * header SOAPAction = endpoints.divide

  Scenario Outline: Tester toutes les variations de la division et vérifier le résultat

    * def a = <intA>
    * def b = <intB>
    * def expected = '<Result>'

  # Vérification division par zéro et format
    * def checkDivide =
  """
  function(a,b){
    if (b == 0) return { error: 'Division par zéro' }
    if (isNaN(a) || isNaN(b)) return { error: 'Format invalide' }
    return null
  }
  """

    * def preCheck = checkDivide(a,b)

  # Vérification des erreurs attendues
    * if (preCheck && expected == 'ERROR') karate.match(preCheck.error, '#string')

  # Stop scénario si erreur
    * if (preCheck) karate.abort()

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
    * def divideResult = response/soap:Envelope/soap:Body/DivideResponse/DivideResult
    * def resultValue = divideResult * 1

    * print 'Résultat obtenu:', resultValue

  # Vérification du résultat attendu
    * match resultValue == expected * 1

    Examples:
      | intA | intB | Result | Commentaire |
      | 10   | 2    | 5      | division normale |
      | 10   | 0    | ERROR  | division par zéro |
      | 'abc'| 5    | ERROR  | mauvais format intA |
      | 5    | 'xyz'| ERROR  | mauvais format intB |
      | -10  | 2    | -5     | division avec négatif |
      | 10   | -2   | -5     | division avec négatif |
      | -10  | -2   | 5      | négatif / négatif |