Feature: Sample

    Background:
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
        And I have added the following assets of type org.coffeechain.Certificate
            | certificateId | description  | grower           | issuer          |
            | cer1          | good quality | gAlice@email.com | rChad@email.com |
        And I have issued the participant org.coffeechain.Grower#gAlice@email.com with the identity gAlice
        And I have issued the participant org.coffeechain.Buyer#bBob@email.com with the identity bBob
        And I have issued the participant org.coffeechain.Regulator#rChad@email.com with the identity rChad

    #===========================================================================================================================
    # READ ASSETS
    #===========================================================================================================================

    Scenario: Alice can read her Coffee
        When I use the identity gAlice
        Then I should have the following assets of type org.coffeechain.Coffee
            | coffeeId  | coffeeType | quantityInStockInKg | dateOfHarvest | grower           |
            | c1        | Arabica    | 5                   | 2018-04-11    | gAlice@email.com |
            
    Scenario: Bob can read his Request
        When I use the identity bBob
        Then I should have the following assets of type org.coffeechain.Request
            | requestId | coffeeType | quantityInKg | maxPrice | region   | dateToReceive | buyer          |
            | r1        | Arabica    | 2            | 100000   | Southern | 2018-04-21    | bBob@email.com |

    Scenario: Chad can read his Certificate
        When I use the identity rChad
        Then I should have the following assets of type org.coffeechain.Certificate
            | certificateId | description  | grower           | issuer          |
            | cer1          | good quality | gAlice@email.com | rChad@email.com |

    Scenario: Alice can read her Certificate
        When I use the identity gAlice
        Then I should have the following assets of type org.coffeechain.Certificate
            | certificateId | description  | grower           | issuer          |
            | cer1          | good quality | gAlice@email.com | rChad@email.com |

    Scenario: Bob can read Certificate
        When I use the identity bBob
        Then I should have the following assets of type org.coffeechain.Certificate
            | certificateId | description  | grower           | issuer          |
            | cer1          | good quality | gAlice@email.com | rChad@email.com |

    #===========================================================================================================================
    # CREATE ASSETS
    #===========================================================================================================================
    
    Scenario: Bob can send coffee Request
        When I use the identity bBob
        And I submit the following transaction of type org.coffeechain.SendRequest
            | buyer          | requestId | coffeeType | quantityInKg | maxPrice | region   | dateToReceive |
            | bBob@email.com | r2        | Arabica    | 2            | 100000   | Southern | 2018-04-23    |
        Then I should have the following assets of type org.coffeechain.Request
            | requestId | coffeeType | quantityInKg | maxPrice | region   | dateToReceive | buyer          |
            | r2        | Arabica    | 2            | 100000   | Southern | 2018-04-23    | bBob@email.com |

    Scenario: Alice can publish Coffee
        When I use the identity gAlice
        And I submit the following transaction of type org.coffeechain.PublishCoffee
            | grower           | coffeeId | coffeeType | quantityInStockInKg | dateOfHarvest |
            | gAlice@email.com | c2       | Robusta    | 10                  | 2018-04-12    |
        Then I should have the following assets of type org.coffeechain.Coffee
            | coffeeId  | coffeeType | quantityInStockInKg | dateOfHarvest | grower           |
            | c2        | Robusta    | 10                  | 2018-04-12    | gAlice@email.com |

    # Scenario: Alice cannot add assets that Bob owns
    #     When I use the identity alice1
    #     And I add the following asset of type org.coffeechain.SampleAsset
    #         | assetId | owner           | value |
    #         | 3       | bob@email.com   | 30    |
    #     Then I should get an error matching /does not have .* access to resource/

    # Scenario: Bob can add assets that he owns
    #     When I use the identity bob1
    #     And I add the following asset of type org.coffeechain.SampleAsset
    #         | assetId | owner           | value |
    #         | 4       | bob@email.com   | 40    |
    #     Then I should have the following assets of type org.coffeechain.SampleAsset
    #         | assetId | owner           | value |
    #         | 4       | bob@email.com   | 40    |

    # Scenario: Bob cannot add assets that Alice owns
    #     When I use the identity bob1
    #     And I add the following asset of type org.coffeechain.SampleAsset
    #         | assetId | owner           | value |
    #         | 4       | alice@email.com | 40    |
    #     Then I should get an error matching /does not have .* access to resource/

    # Scenario: Alice can update her assets
    #     When I use the identity alice1
    #     And I update the following asset of type org.coffeechain.SampleAsset
    #         | assetId | owner           | value |
    #         | 1       | alice@email.com | 50    |
    #     Then I should have the following assets of type org.coffeechain.SampleAsset
    #         | assetId | owner           | value |
    #         | 1       | alice@email.com | 50    |

    # Scenario: Alice cannot update Bob's assets
    #     When I use the identity alice1
    #     And I update the following asset of type org.coffeechain.SampleAsset
    #         | assetId | owner           | value |
    #         | 2       | bob@email.com   | 50    |
    #     Then I should get an error matching /does not have .* access to resource/

    # Scenario: Bob can update his assets
    #     When I use the identity bob1
    #     And I update the following asset of type org.coffeechain.SampleAsset
    #         | assetId | owner         | value |
    #         | 2       | bob@email.com | 60    |
    #     Then I should have the following assets of type org.coffeechain.SampleAsset
    #         | assetId | owner         | value |
    #         | 2       | bob@email.com | 60    |

    # Scenario: Bob cannot update Alice's assets
    #     When I use the identity bob1
    #     And I update the following asset of type org.coffeechain.SampleAsset
    #         | assetId | owner           | value |
    #         | 1       | alice@email.com | 60    |
    #     Then I should get an error matching /does not have .* access to resource/

    # Scenario: Alice can remove her assets
    #     When I use the identity alice1
    #     And I remove the following asset of type org.coffeechain.SampleAsset
    #         | assetId |
    #         | 1       |
    #     Then I should not have the following assets of type org.coffeechain.SampleAsset
    #         | assetId |
    #         | 1       |

    # Scenario: Alice cannot remove Bob's assets
    #     When I use the identity alice1
    #     And I remove the following asset of type org.coffeechain.SampleAsset
    #         | assetId |
    #         | 2       |
    #     Then I should get an error matching /does not have .* access to resource/

    # Scenario: Bob can remove his assets
    #     When I use the identity bob1
    #     And I remove the following asset of type org.coffeechain.SampleAsset
    #         | assetId |
    #         | 2       |
    #     Then I should not have the following assets of type org.coffeechain.SampleAsset
    #         | assetId |
    #         | 2       |

    # Scenario: Bob cannot remove Alice's assets
    #     When I use the identity bob1
    #     And I remove the following asset of type org.coffeechain.SampleAsset
    #         | assetId |
    #         | 1       |
    #     Then I should get an error matching /does not have .* access to resource/

    # Scenario: Alice can submit a transaction for her assets
    #     When I use the identity alice1
    #     And I submit the following transaction of type org.coffeechain.SampleTransaction
    #         | asset | newValue |
    #         | 1     | 50       |
    #     Then I should have the following assets of type org.coffeechain.SampleAsset
    #         | assetId | owner           | value |
    #         | 1       | alice@email.com | 50    |
    #     And I should have received the following event of type org.coffeechain.SampleEvent
    #         | asset   | oldValue | newValue |
    #         | 1       | 10       | 50       |

    # Scenario: Alice cannot submit a transaction for Bob's assets
    #     When I use the identity alice1
    #     And I submit the following transaction of type org.coffeechain.SampleTransaction
    #         | asset | newValue |
    #         | 2     | 50       |
    #     Then I should get an error matching /does not have .* access to resource/

    # Scenario: Bob can submit a transaction for his assets
    #     When I use the identity bob1
    #     And I submit the following transaction of type org.coffeechain.SampleTransaction
    #         | asset | newValue |
    #         | 2     | 60       |
    #     Then I should have the following assets of type org.coffeechain.SampleAsset
    #         | assetId | owner         | value |
    #         | 2       | bob@email.com | 60    |
    #     And I should have received the following event of type org.coffeechain.SampleEvent
    #         | asset   | oldValue | newValue |
    #         | 2       | 20       | 60       |

    # Scenario: Bob cannot submit a transaction for Alice's assets
    #     When I use the identity bob1
    #     And I submit the following transaction of type org.coffeechain.SampleTransaction
    #         | asset | newValue |
    #         | 1     | 60       |
    #     Then I should get an error matching /does not have .* access to resource/
