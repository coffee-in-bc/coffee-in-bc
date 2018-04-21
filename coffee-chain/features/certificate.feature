Feature: Certficate

    Background: Setup the participant
        Given I have deployed the business network definition ..
        And I have added the following participants
            """
            [
            {"$class":"org.coffeechain.Grower",
            "growerId":"gAlice@email.com", "firstName":"Alice", "lastName":"A",
            "farmName":"CoffeeGo", "farmAltitude":1500, "farmRegion":"Southern",
            "coffeeTypes":["Arabica,Robusta"]}
            ]
            """
        And I have added the following participants of type org.coffeechain.Regulator
            | regulatorId        | regulatorOrgName |
            | rChad@email.com    | VietGAP          |
        And I have issued the participant org.coffeechain.Grower#gAlice@email.com with the identity gAlice
        And I have issued the participant org.coffeechain.Regulator#rChad@email.com with the identity rChad

    Scenario: Chad can give certficiate to Alice
        When I use the identity rChad
        And I submit the following transaction of type org.coffeechain.IssueCertificate
            | issuer          | grower           | certificateId | description |
            | rChad@email.com | gAlice@email.com | Chad2Alice    | he has the best cf |
        Then I should have the following assets of type org.coffeechain.Certificate
            | certificateId | description | valid | grower | issuer |
            | Chad2Alice | he has the best cf | true | gAlice@email.com | rChad@email.com |
        
        And I submit the following transaction of type org.coffeechain.IssueCertificate
            | issuer          | grower           | certificateId | description | valid |
            | rChad@email.com | gAlice@email.com | Chad2Alicei2    | he droped his quality | false |
        Then I should have the following assets of type org.coffeechain.Certificate
            | certificateId | description | valid | grower | issuer |
            | Chad2Alicei2 | he droped his quality | false | gAlice@email.com | rChad@email.com |
