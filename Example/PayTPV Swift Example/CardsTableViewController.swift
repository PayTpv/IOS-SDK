//
//  CardsTableViewController.swift
//  PAYTPV Swift Example
//
//  Created by Mihail Cristian Dumitru on 8/17/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

import UIKit
import PAYTPV

@objc protocol CardsTableControllerDelegate {
    func cardsTableController(_ controller: CardsTableViewController, didSelectCard card: Card)
}

class CardsTableViewController: UITableViewController {

    // MARK: - Properties

    weak var delegate: CardsTableControllerDelegate?

    var cards: [Card] = []

    var addButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.onAddButtonPressed))
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.loadRemoteData()
    }

    // MARK: - Setup

    private func setup() {
        self.title = "Cards"

        self.navigationItem.rightBarButtonItems = [self.addButtonItem, self.editButtonItem]
    }

    // MARK: - Helpers

    func onAddButtonPressed() {
        let addCardController = AddCardController()
        addCardController.delegate = self
        self.present(addCardController, animated: true, completion: nil)
    }

    func loadRemoteData() {
        ModelStore.getCards { (cards) in
            self.cards = cards
            self.reloadData()
        }
    }

    func reloadData() {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell") ?? UITableViewCell(style: .value1, reuseIdentifier: "CardCell")

        let card = self.cards[indexPath.row]

        cell.textLabel?.text = card.name

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            // add a loading indicator
            let loader = AlertBuilder()
                .set(title: "Removing card")
                .addLoadingIndicator()
                .present(sender: self)

            let selectedCard = self.cards[indexPath.row]

            // call the PAYTPV api to remove the user from the system
            let user = PTPVUser(idUser: selectedCard.id, tokenUser: selectedCard.token)
            PTPVAPIClient.shared().remove(user, completion: { (error) in
                loader.dismiss()

                if let error = error {
                    let _ = AlertBuilder()
                        .set(message: error.localizedDescription)
                        .add(actionWithTitle: "OK")
                        .present(sender: self)
                    return;
                }

                // remove the user from the backend
                ModelStore.remove(card: selectedCard, completion: { (_) in
                    self.loadRemoteData()
                })
            })

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedCard = self.cards[indexPath.row]

        self.delegate?.cardsTableController(self, didSelectCard: selectedCard)
    }

}

// MARK: - AddCardDelegate

extension CardsTableViewController: AddCardDelegate {

    func addCardController(_ controller: AddCardController, didFinishAddingCard card: Card) {
        self.reloadData()
    }

}
