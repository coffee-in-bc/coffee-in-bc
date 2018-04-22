Feature: Certficate

    Background: Setup the participant
        Given I have deployed the business network definition ..
        And I have added the following participants
            """
            [
            {"$class":"org.coffeechain.Grower",
            "growerId":"gAlice@email.com", "firstName":"Alice", "lastName":"A",
            "farmName":"CoffeeGo", "farmAltitude":1500, "farmRegion":"Southern",
            "coffeeTypes":["Arabica","Robusta"]}
            ]
            """
        And I have added the following participants of type org.coffeechain.Regulator
            | regulatorId        | regulatorOrgName |
            | rChad@email.com    | VietGAP          |
        And I have added the following assets of type org.coffeechain.Certificate
            """
            [
            {"$class":"org.coffeechain.Certificate",
            "certificateId":"cer1", "description":"good quality", "valid":true,
            "grower":"gAlice@email.com", "issuer":"rChad@email.com"}
            ]
            """
        And I have issued the participant org.coffeechain.Grower#gAlice@email.com with the identity gAlice
        And I have issued the participant org.coffeechain.Regulator#rChad@email.com with the identity rChad

    #===========================================================================================================================
    # READ ASSETS
    #===========================================================================================================================

    Scenario: Chad can read his Certificate
        When I use the identity rChad
        Then I should have the following assets of type org.coffeechain.Certificate
            """
            [
            {"$class":"org.coffeechain.Certificate",
            "certificateId":"cer1", "description":"good quality", "valid":true,
            "grower":"gAlice@email.com", "issuer":"rChad@email.com"}
            ]
            """

    #===========================================================================================================================
    # SUBMIT TRANSACTION
    #===========================================================================================================================

    Scenario: Chad can give certficiate to Alice
        When I use the identity rChad
        And I submit the following transaction of type org.coffeechain.IssueCertificate
            | issuer          | grower           | certificateId | description | valid |
            | rChad@email.com | gAlice@email.com | Chad2Alice    | he has the best cf | true |
        Then I should have the following assets of type org.coffeechain.Certificate
            | certificateId | description | valid | grower | issuer |
            | Chad2Alice | he has the best cf | true | gAlice@email.com | rChad@email.com |
        
        And I submit the following transaction of type org.coffeechain.IssueCertificate
            | issuer          | grower           | certificateId | description | valid |
            | rChad@email.com | gAlice@email.com | Chad2Alicei2    | he droped his quality | false |
        Then I should have the following assets of type org.coffeechain.Certificate
            | certificateId | description | valid | grower | issuer |
            | Chad2Alicei2 | he droped his quality | true | gAlice@email.com | rChad@email.com |

    Scenario: Chad can cancel a certificate of Alice
        When I use the identity rChad
        And I submit the following transaction of type org.coffeechain.CancelCertificate
            | certificate | description      |
            | cer1        | quality gone bad |
        Then I should have the following assets
            """
            [
            {"$class":"org.coffeechain.Certificate",
            "certificateId":"cer1", "description":"quality gone bad", "valid":false,
            "grower":"gAlice@email.com", "issuer":"rChad@email.com"}
            ]
            """