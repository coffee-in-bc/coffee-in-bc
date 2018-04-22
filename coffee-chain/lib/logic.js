'use strict';

/**
 * Publish Coffee
 * @param {org.coffeechain.PublishCoffee} publishCoffee
 * @transaction
 */
async function publishCoffee(publishCoffee) {
    let factory = getFactory()

    let coffee = factory.newResource('org.coffeechain', 'Coffee', publishCoffee.coffeeId)
    coffee.coffeeType = publishCoffee.coffeeType
    coffee.quantityInStockInKg = publishCoffee.quantityInStockInKg
    coffee.dateOfHarvest = new Date(publishCoffee.dateOfHarvest)
    coffee.grower = publishCoffee.grower

    const registryCoffee = await getAssetRegistry("org.coffeechain.Coffee")
    await registryCoffee.add(coffee)
}

/**
 * Send Coffee Request
 * @param {org.coffeechain.SendRequest} sendRequest
 * @transaction
 */
async function sendRequest(sendRequest) {
    let factory = getFactory()

    let request = factory.newResource('org.coffeechain', 'Request', sendRequest.requestId)
    request.coffeeType = sendRequest.coffeeType
    request.quantityInKg = sendRequest.quantityInKg
    request.maxPrice = sendRequest.maxPrice
    request.region = sendRequest.region
    request.dateToReceive = new Date(sendRequest.dateToReceive)
    request.buyer = sendRequest.buyer

    const registryRequest = await getAssetRegistry("org.coffeechain.Request")
    await registryRequest.add(request)
}

/**
 * Send Coffee Offer
 * @param {org.coffeechain.SendOffer} sendOffer
 * @transaction
 */
async function sendOffer(sendOffer) {
    let factory = getFactory()

    let offer = factory.newResource('org.coffeechain', 'Offer', sendOffer.offerId)
    offer.price = sendOffer.price
    offer.grower = sendOffer.grower
    offer.request = sendOffer.request

    const registryOffer = await getAssetRegistry("org.coffeechain.Offer")
    await registryOffer.add(offer)
}

/**
 * Issue Quality Certificate
 * @param {org.coffeechain.IssueCertificate} issueCertificate
 * @transaction
 */
async function issueCertificate(issueCertificate) {
    let factory = getFactory()

    let certificate = factory.newResource('org.coffeechain', 'Certificate', issueCertificate.certificateId)
    certificate.description = issueCertificate.description
    certificate.grower = issueCertificate.grower
    certificate.issuer = issueCertificate.issuer
    certificate.valid = issueCertificate.valid

    const registryCertificate = await getAssetRegistry("org.coffeechain.Certificate")
    await registryCertificate.add(certificate)
}
