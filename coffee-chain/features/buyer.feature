Feature: Grower

    Background:
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
        And I have added the following participants of type org.coffeechain.Buyer
            | buyerId            | firstName   | lastName | 
            | bBob@email.com     | Bob         | B        |
        And I have added the following participants of type org.coffeechain.Regulator
            | regulatorId        | regulatorOrgName |
            | rChad@email.com    | VietGAP          |
        And I have added the following assets of type org.coffeechain.Coffee
            | coffeeId  | coffeeType | quantityInStockInKg | maxPrice | region   | dateOfHarvest | grower           |
            | c1        | Arabica    | 5                   | 100000   | Southern | 2018-04-11    | gAlice@email.com |
        And I have added the following assets of type org.coffeechain.Request
            | requestId | coffeeType | quantityInKg | maxPrice | region   | dateToReceive | buyer          |
            | r1        | Arabica    | 2            | 100000   | Southern | 2018-04-21    | bBob@email.com |
        And I have added the following assets of type org.coffeechain.Offer
            """
            [
            {"$class":"org.coffeechain.Offer",
            "offerId":"o1", "price":300000, "accepted":false, "request":"r1", "grower":"gAlice@email.com"}
            ]
            """
        And I have added the following assets of type org.coffeechain.Certificate
            | certificateId | description  | grower           | issuer          | valid |
            | cer1          | good quality | gAlice@email.com | rChad@email.com | true  |
        And I have issued the participant org.coffeechain.Grower#gAlice@email.com with the identity gAlice
        And I have issued the participant org.coffeechain.Buyer#bBob@email.com with the identity bBob
        And I have issued the participant org.coffeechain.Regulator#rChad@email.com with the identity rChad

    #===========================================================================================================================
    # READ ASSETS
    #===========================================================================================================================

    Scenario: Bob can read his Request
        When I use the identity bBob
        Then I should have the following assets of type org.coffeechain.Request
            | requestId | coffeeType | quantityInKg | maxPrice | region   | dateToReceive | buyer          |
            | r1        | Arabica    | 2            | 100000   | Southern | 2018-04-21    | bBob@email.com |

    Scenario: Bob can read Certificate
        When I use the identity bBob
        Then I should have the following assets of type org.coffeechain.Certificate
            | certificateId | description  | grower           | issuer          | valid |
            | cer1          | good quality | gAlice@email.com | rChad@email.com | true  |

    Scenario: Bob can read Offers for him
        When I use the identity bBob
        Then I should have the following assets of type org.coffeechain.Offer
            """
            [
            {"$class":"org.coffeechain.Offer",
            "offerId":"o1", "price":300000, "accepted":false, "request":"r1", "grower":"gAlice@email.com"}
            ]
            """

    #===========================================================================================================================
    # SUBMIT TRANSACTION
    #===========================================================================================================================

    Scenario: Bob can send coffee Request
        When I use the identity bBob
        And I submit the following transaction of type org.coffeechain.SendRequest
            | buyer          | requestId | coffeeType | quantityInKg | maxPrice | region   | dateToReceive |
            | bBob@email.com | r2        | Arabica    | 2            | 100000   | Southern | 2018-04-23    |
        Then I should have the following assets of type org.coffeechain.Request
            | requestId | coffeeType | quantityInKg | maxPrice | region   | dateToReceive | buyer          |
            | r2        | Arabica    | 2            | 100000   | Southern | 2018-04-23    | bBob@email.com |

    # Scenario: Bob can accept an Offer
    #     When I use the identity bBob
    #     And I submit the following transaction of type org.coffeechain.AcceptOffer
    #         | offer | dealId | dateOfTransaction |
    #         | o1    | d1     | 2018-04-24        |
    #     Then I should have the following assets
    #         """
    #         [
    #         {"$class":"org.coffeechain.Offer",
    #         "offerId":"o1", "price":300000, "accepted":true, "request":"r1", "grower":"gAlice@email.com"}
    #         ]
    #         """
