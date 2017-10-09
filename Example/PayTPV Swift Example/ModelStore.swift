//
//  CardStore.swift
//  PAYTPV Swift Example
//
//  Created by Mihail Cristian Dumitru on 8/18/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

import UIKit

/// In a real production app, this should be the api connected to your backend which you can use to send the tokenized user data from PAYTPV. For the purpose of the demo, we just store it in UserDefaults
class ModelStore {

    private static let kCardStore = "kCardStore"
    private static let kPurchaseStore = "kPurchaseStore"

    private static var cards: [Card] = {
        guard let cardsData = UserDefaults.standard.data(forKey: kCardStore) else {
            return []
        }
        guard let cards = NSKeyedUnarchiver.unarchiveObject(with: cardsData) as? [Card] else {
            return []
        }
        return cards
    }()

    private static var purchases: [Purchase] = {
        guard let purchasesData = UserDefaults.standard.data(forKey: kPurchaseStore) else {
            return []
        }
        guard let purchases = NSKeyedUnarchiver.unarchiveObject(with: purchasesData) as? [Purchase] else {
            return []
        }
        return purchases
    }()

    private static func save() {
        let cardsData = NSKeyedArchiver.archivedData(withRootObject: self.cards)
        UserDefaults.standard.set(cardsData, forKey: kCardStore)
    }

    public static func getCards(completion: (([Card]) -> Void)? = nil) {
        completion?(cards)
    }

    public static func add(card: Card, completion: (() -> Void)? = nil) {
        self.cards.append(card)
        self.save()
        completion?()
    }

    public static func remove(card: Card, completion: (() -> Void)? = nil) {
        if let index = self.cards.index(where: { $0 == card }) {
            self.cards.remove(at: index)
        }
        self.save()
        completion?()
    }

    public static func getPurchases(completion: (([Purchase]) -> Void)? = nil) {
        completion?(purchases)
    }

    public static func add(purchase: Purchase, completion: (() -> Void)? = nil) {
        self.purchases.append(purchase)
        self.save()
        completion?()
    }

    public static func remove(purchase: Purchase, completion: (() -> Void)? = nil) {
        if let index = self.purchases.index(where: { $0 == purchase }) {
            self.purchases.remove(at: index)
        }
        self.save()
        completion?()
    }

}

