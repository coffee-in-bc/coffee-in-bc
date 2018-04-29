'use strict';

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
    if (sendOffer.price > sendOffer.request.maxPrice) {
        throw "Offer price is higher than Request maxPrice"
    }

    let factory = getFactory()

    let offer = factory.newResource('org.coffeechain', 'Offer', sendOffer.offerId)
    offer.price = sendOffer.price
    offer.grower = sendOffer.grower
    offer.request = sendOffer.request
    
    const registryOffer = await getAssetRegistry("org.coffeechain.Offer")
    await registryOffer.add(offer)

    const registryRequest = await getAssetRegistry("org.coffeechain.Request")
    await registryRequest.update(sendOffer.request)
}

/**
 * Accept Offer
 * @param {org.coffeechain.AcceptOffer} acceptOffer
 * @transaction
 */
async function acceptOffer(acceptOffer) {
    let offer = acceptOffer.offer
    let request = offer.request
    let grower = offer.grower
    let buyer = request.buyer

    offer.accepted = true

    let factory = getFactory()
    
    let dealId = offer.offerId + request.requestId

    let deal = factory.newResource('org.coffeechain', 'Deal', dealId)
    deal.coffeeType = request.coffeeType
    deal.farmName = grower.farmName
    deal.farmRegion = grower.farmRegion
    deal.farmAltitude = grower.farmAltitude
    deal.quantityInKg = request.quantityInKg
    deal.dateOfTransaction = new Date()  
    deal.grower = grower
    deal.buyer = buyer  

    const registryOffer = await getAssetRegistry("org.coffeechain.Offer")
    await registryOffer.update(acceptOffer.offer)

    const registryDeal = await getAssetRegistry("org.coffeechain.Deal")
    await registryDeal.add(deal)
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

/**
 * Cancel Certificate
 * @param {org.coffeechain.CancelCertificate} cancelCertificate
 * @transaction
 */
async function cancelCertificate(cancelCertificate) {
    cancelCertificate.certificate.valid = false
    cancelCertificate.certificate.description = cancelCertificate.description

    const registryCertificate = await getAssetRegistry("org.coffeechain.Certificate")
    await registryCertificate.update(cancelCertificate.certificate)
}
