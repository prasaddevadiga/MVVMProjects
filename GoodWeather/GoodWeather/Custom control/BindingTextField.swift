//
//  BindingTextField.swift
//  GoodWeather
//
//  Created by Prasad on 5/8/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation
import UIKit

class BindingTextField: UITextField {
    
    var textChangeCallBack: (String) -> () = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func bind(callBack: @escaping (String) -> ()) {
        self.textChangeCallBack = callBack
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        self.textChangeCallBack(text)
    }
}
