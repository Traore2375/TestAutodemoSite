Feature: Addition via SOAP

  Background:
    * url baseUrl
    * configure headers = headers
    * header SOAPAction = endpoints.add

  Scenario Outline: Add numbers using SOAP
    # Définition des variables pour ce scénario
    * def a = <a>
    * def b = <b>

    # Corps de la requête SOAP
    Given request
    """
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
        <soap:Body>
             <Add xmlns="http://tempuri.org/">
                <intA><a></intA>
                <intB><b></intB>
            </Add>
        </soap:Body>
    </soap:Envelope>
    """

    When method post
    Then status 200
    # Optionnel : vérifier que la réponse contient le résultat correct

        #* def resultValue = parseInt()
    And match response //AddResult == '<result>'

    Examples:
      | a  | b  | result| Commentaire                |
      | 5  | 3  | 8  |    addition positif           |
      | 10 | 7  | 17 | addition positif              |
      | 10 | -3 | 7  | addition avec nbre negatif    |
      | -5 | -5 |-10 | addition avec nbre negatif    |
      | 'abc'| 5| ERROR | mauvais format intA        |