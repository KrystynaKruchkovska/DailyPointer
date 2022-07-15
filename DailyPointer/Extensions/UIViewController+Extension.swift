//
//  UIViewController.swift
//  DailyPointer
//
//  Created by Paweł on 14/07/2022.
//

import Foundation
import UIKit

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
    }
}
