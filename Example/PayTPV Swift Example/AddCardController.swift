//
//  AddCardController.swift
//  PAYTPV Swift Example
//
//  Created by Mihail Cristian Dumitru on 8/18/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

import UIKit
import PAYTPV

@objc protocol AddCardDelegate {
    func addCardController(_ controller: AddCardController, didFinishAddingCard card: Card)
}

class AddCardController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var panTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!

    // MARK: - Properties

    weak var delegate: AddCardDelegate?

    var pan: String {
        return self.panTextField.text ?? ""
    }

    var expiryDate: String {
        return "\(self.monthTextField.text ?? "")\(self.yearTextField.text ?? "")"
    }

    var cvv: String {
        return self.cvvTextField.text ?? ""
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    // MARK: - Setup

    func setup() {
        self.title = "Add a card"

        self.setupTextFields()
    }

    func setupTextFields() {
        self.panTextField.delegate = self
        self.monthTextField.delegate = self
        self.yearTextField.delegate = self
        self.cvvTextField.delegate = self
    }

    // MARK: - Helpers

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func string(string: String, matchesRegex regexString: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regexString, options: .caseInsensitive)

            return regex.numberOfMatches(in: string, options: [], range: NSRange(location: 0, length: string.characters.count)) > 0
        } catch (_) {

        }

        return true
    }

    func valid(pan: String) -> Bool {
        return self.string(string: pan, matchesRegex: "^[0-9]{0,19}$")
    }

    func valid(month: String) -> Bool {
        return self.string(string: month, matchesRegex: "(^0[1-9]?$)|(^1[012]?$)")
    }

    func valid(year: String) -> Bool {
        return self.string(string: year, matchesRegex: "(1[6-9]?$)|(^[2-9][0-9]?$)")
    }

    func valid(cvv: String) -> Bool {
        return self.string(string: cvv, matchesRegex: "^[0-9]{0,4}$")
    }

    // MARK: - IBActions

    @IBAction func onAddCardButtonPressed(_ sender: UIButton) {
        // add a loading indicator
        let loader = AlertBuilder()
            .set(title: "Adding card")
            .addLoadingIndicator()
            .present(sender: self)

        // make the request to PAYTPV
        let card = PTPVCard(pan: self.pan, expiryDate: self.expiryDate, cvv: self.cvv)

        PTPVAPIClient.shared().addUser(card) { (user, error) in
            loader.dismiss(animated: true, completion: { 
                guard let user = user else {
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

                // send the user token to the backend
                let card = Card(id: user.idUser ?? "", token: user.tokenUser ?? "", name: self.pan)
                ModelStore.add(card: card, completion: { (_) in
                    self.dismiss(animated: true, completion: {
                        self.delegate?.addCardController(self, didFinishAddingCard: card)
                    })
                })
            })
        }
    }

    @IBAction func onCancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

// MARK: - UITextFieldDelegate

extension AddCardController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text as NSString? else {
            return true
        }

        let newLength = text.length + string.characters.count - range.length
        if newLength == 0 {
            return true
        }

        let newString = text.replacingCharacters(in: range, with: string)

        switch textField {
        case self.panTextField:
            return self.valid(pan: newString)

        case self.monthTextField:
            return self.valid(month: newString)

        case self.yearTextField:
            return self.valid(year: newString)

        case self.cvvTextField:
            return self.valid(cvv: newString)

        default: break
        }

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.panTextField:
            self.monthTextField.becomeFirstResponder()

        case self.monthTextField:
            self.yearTextField.becomeFirstResponder()

        case self.yearTextField:
            self.cvvTextField.becomeFirstResponder()
            
        default: break
        }
        
        return true
    }
    
}
