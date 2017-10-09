//
//  AlertBuilder.swift
//  PAYTPV Swift Example
//
//  Created by Mihail Cristian Dumitru on 8/18/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

import UIKit

class AlertBuilder {

    // MARK: - Properties

    var alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

    // MARK: - Helpers

    func set(title: String?) -> Self {
        self.alertController.title = title
        return self
    }

    func set(message: String?) -> Self {
        self.alertController.message = message
        return self
    }

    func add(actionWithTitle title: String?, style: UIAlertActionStyle = .default, handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        self.alertController.addAction(
            UIAlertAction(
                title: title,
                style: style,
                handler: handler
            )
        )
        return self
    }

    func addLoadingIndicator() -> Self {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.addSubview(indicator)

        let views = ["pending" : alertController.view, "indicator" : indicator]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[indicator]-(-50)-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[indicator]|", options: [], metrics: nil, views: views)
        alertController.view.addConstraints(constraints)

        indicator.isUserInteractionEnabled = false
        indicator.startAnimating()

        return self
    }

    func present(sender: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) -> Self {
        sender.present(self.alertController, animated: animated, completion: completion)

        return self
    }

    func dismiss(animated: Bool = true, completion:(() -> Void)? = nil) {
        self.alertController.dismiss(animated: animated, completion: completion)
    }

}
