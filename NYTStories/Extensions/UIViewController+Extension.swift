//
//  UIViewController+Extension.swift
//  NYTStories
//
//  Created by Hesham on 28/09/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showOKAlert(title: String, message: String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
