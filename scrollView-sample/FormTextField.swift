//
//  FormTextField.swift
//  scrollView-sample
//
//  Created by Yasin Akbaş on 24.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class FormTextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureMainTextField() {
        textColor = .white
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        textAlignment = .center
        tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        font = UIFont.setFont(name: .avenirnextregular, size: 16)
    }
    
    //---------------------------- padding space ----------------------------//
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

       override open func textRect(forBounds bounds: CGRect) -> CGRect {
           return bounds.inset(by: padding)
       }

       override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
           return bounds.inset(by: padding)
       }

       override open func editingRect(forBounds bounds: CGRect) -> CGRect {
           return bounds.inset(by: padding)
       }
    
    //---------------------------- place holder ----------------------------//
    func addPlaceholder(text: String) {
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)]
        )
    }

}
