//
//  PurchasesViewController.swift
//  PAYTPV Swift Example
//
//  Created by Mihail Cristian Dumitru on 8/22/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

import UIKit
import PAYTPV

class PurchasesViewController: UITableViewController {

    // MARK: - Properties

    var purchases: [Purchase] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Purchases"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.loadRemoteData()
    }

    // MARK: - Helpers

    func loadRemoteData() {
        ModelStore.getPurchases { (purchases) in
            self.purchases = purchases
            self.reloadData()
        }
    }

    func reloadData() {
        self.tableView.reloadData()
    }

    func refund(purchase: Purchase) {
        // add a loading indicator
        let loader = AlertBuilder()
            .set(title: "Refunding purchase")
            .addLoadingIndicator()
            .present(sender: self)

        let refund = PTPVRefund(authCode: purchase.authCode, order: purchase.order, currency: purchase.currency)
        let user = PTPVUser(idUser: purchase.card.id, tokenUser: purchase.card.token)

        // make the request to PAYTPV
        PTPVAPIClient.shared().execute(refund, for: user) { (refund, error) in
            loader.dismiss()

            if let error = error {
                let _ = AlertBuilder()
                    .set(message: error.localizedDescription)
                    .add(actionWithTitle: "OK")
                    .present(sender: self)
                return;
            }

            // remove the purchase from the backend
            ModelStore.remove(purchase: purchase, completion: {
                let _ = AlertBuilder()
                    .set(message: "Purchase refunded!")
                    .add(actionWithTitle: "OK", style: .default, handler: { (_) in
                        let _ = self.navigationController?.popToRootViewController(animated: true)
                    })
                    .present(sender: self)
            })
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.purchases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCell") ?? UITableViewCell(style: .value1, reuseIdentifier: "PurchaseCell")

        let purchase = self.purchases[indexPath.row]

        cell.textLabel?.text = purchase.order

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPurchase = self.purchases[indexPath.row]

        // ask for user's confirmation
        let _ = AlertBuilder()
            .set(message: "Do you want to refund the order \(selectedPurchase.order)?")
            .add(actionWithTitle: "No", style: .cancel, handler: nil)
            .add(actionWithTitle: "Yes", style: .default) { (_) in
                // make the refund
                self.refund(purchase: selectedPurchase)
            }
            .present(sender: self)
    }

}
