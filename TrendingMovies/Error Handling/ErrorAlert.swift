//
//  ErrorAlert.swift
//  TrendingMovies
//
//  Created by Marina on 21/06/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(withMessage message: String) {
        let title = String(localizedKey: Constants.AlertTexts.title)
        let okButtonTitle = String(localizedKey: Constants.AlertTexts.okButton)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: okButtonTitle, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
