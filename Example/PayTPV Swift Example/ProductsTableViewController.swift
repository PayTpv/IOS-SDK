//
//  ProductsTableViewController.swift
//  PAYTPV Swift Example
//
//  Created by Mihail Cristian Dumitru on 8/17/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

import UIKit
import PAYTPV

class ProductsTableViewController: UITableViewController {

    // MARK: - Properties

    let products: [Product] = [
        Product(name: "Product A", price: 0.29, currency: PTPVCurrencyEUR),
        Product(name: "Product B", price: 1.99, currency: PTPVCurrencyEUR),
        Product(name: "Product C", price: 2.99, currency: PTPVCurrencyEUR),
        Product(name: "Product D", price: 3.99, currency: PTPVCurrencyEUR),
    ]

    var selectedProduct: Product?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    // MARK: - Setup

    func setup() {
        self.title = "Products"

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Purchases", style: .plain, target: self, action: #selector(self.onPurchasesButtonPressed))
    }

    // MARK: - Helpers

    func onPurchasesButtonPressed() {
        self.navigationController?.pushViewController(PurchasesViewController(), animated: true)
    }

    func purchase(product: Product, withCard card: Card) {
        // add a loading indicator
        let loader = AlertBuilder()
            .set(title: "Executing purchase")
            .addLoadingIndicator()
            .present(sender: self)

        // the amount must be in integer format, so we have to convert it
        // e.g. 1.00 EURO = 100, 4.50 EUROS = 450...
        let amount = NSNumber(integerLiteral: Int((product.price * 100.0).rounded()))

        // generate unique order reference
        let order = String(format: "%.0f_%d", Date().timeIntervalSince1970, arc4random_uniform(1000))

        // create the purchase request
        let purchaseRequest = PTPVPurchaseRequest(amount: amount,
                                                  order: order,
                                                  currency: product.currency,
                                                  productDescription: nil,
                                                  owner: nil,
                                                  scoring: nil)

        let user = PTPVUser(idUser: card.id, tokenUser: card.token)

        // make the request to PAYTPV
        PTPVAPIClient.shared().executePurchase(purchaseRequest, for: user, completion: { (purchase, error) in
            loader.dismiss()

            guard let purchase = purchase else {
                if let error = error {
                    let _ = AlertBuilder()
                        .set(message: error.localizedDescription)
                        .add(actionWithTitle: "OK")
                        .present(sender: self)
                    return;
                }
                let _ = AlertBuilder()
                    .set(message: "There was an unexpected error. Please try again later.")
                    .add(actionWithTitle: "OK")
                    .present(sender: self)
                return;
            }

            // send the purchase details to the backend
            let localPurchase = Purchase(order: purchase.order ?? "",
                                         authCode: purchase.authCode ?? "",
                                         currency: purchase.currency ?? "",
                                         card: card)
            ModelStore.add(purchase: localPurchase, completion: {
                let _ = AlertBuilder()
                    .set(message: "Product purchased!")
                    .add(actionWithTitle: "OK", style: .default, handler: { (_) in
                        let _ = self.navigationController?.popToRootViewController(animated: true)
                    })
                    .present(sender: self)
            })
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") ?? UITableViewCell(style: .value1, reuseIdentifier: "ProductCell")

        let product = self.products[indexPath.row]

        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = "\(product.currency) \(product.price)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedProduct = self.products[indexPath.row]

        let cardsController = CardsTableViewController()
        cardsController.delegate = self

        self.navigationController?.pushViewController(cardsController, animated: true)
    }

}

// MARK: - CardsTableControllerDelegate

extension ProductsTableViewController: CardsTableControllerDelegate {

    func cardsTableController(_ controller: CardsTableViewController, didSelectCard card: Card) {
        guard let selectedProduct = self.selectedProduct else {
            return;
        }

        // ask for user's confirmation
        let _ = AlertBuilder()
            .set(message: "Are you sure you want to purchase \(selectedProduct.name) for \(selectedProduct.currency) \(selectedProduct.price)?")
            .add(actionWithTitle: "No", style: .cancel, handler: nil)
            .add(actionWithTitle: "Yes", style: .default) { (_) in
                // make the purchase
                self.purchase(product: selectedProduct, withCard: card)
            }
            .present(sender: self)
    }

}
