//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by Alvaro Santiesteban on 5/25/17.
//  Copyright © 2017 3vts. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

}
