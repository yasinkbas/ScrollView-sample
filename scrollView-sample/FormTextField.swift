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
    }
    

}
