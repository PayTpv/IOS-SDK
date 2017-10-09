//
//  Models.swift
//  PAYTPV Swift Example
//
//  Created by Mihail Cristian Dumitru on 8/18/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

import UIKit

class Card: NSObject, NSCoding {

    // MARK: - Properties

    var id: String = ""
    var token: String = ""
    var name: String = ""

    // MARK: - Inits

    override init() {
        super.init()
    }

    init(id: String, token: String, name: String) {
        self.id = id
        self.token = token
        self.name = name
    }

    // MARK: - NSCoding

    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        self.token = aDecoder.decodeObject(forKey: "token") as? String ?? ""
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.token, forKey: "token")
        aCoder.encode(self.name, forKey: "name")
    }

    // MARK: - Equatable

    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id && lhs.token == rhs.token && lhs.name == rhs.name
    }

}

class Purchase: NSObject, NSCoding {

    // MARK: - Properties

    var order: String = ""
    var authCode: String = ""
    var currency: String = ""
    var card: Card = Card()

    // MARK: - Inits

    init(order: String, authCode: String, currency: String, card: Card) {
        self.order = order
        self.authCode = authCode
        self.currency = currency
        self.card = card
    }

    // MARK: - NSCoding

    required init?(coder aDecoder: NSCoder) {
        self.order = aDecoder.decodeObject(forKey: "order") as? String ?? ""
        self.authCode = aDecoder.decodeObject(forKey: "authCode") as? String ?? ""
        self.currency = aDecoder.decodeObject(forKey: "currency") as? String ?? ""
        self.card = aDecoder.decodeObject(forKey: "card") as? Card ?? Card()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.order, forKey: "order")
        aCoder.encode(self.authCode, forKey: "authCode")
        aCoder.encode(self.currency, forKey: "currency")
        aCoder.encode(self.card, forKey: "card")
    }

    // MARK: - Equatable

    static func ==(lhs: Purchase, rhs: Purchase) -> Bool {
        return lhs.order == rhs.order && lhs.authCode == rhs.authCode && lhs.currency == rhs.currency && lhs.card == rhs.card
    }

}

struct Product {
    var name: String
    var price: Double
    var currency: String
}
