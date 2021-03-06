//
//  FormView.swift
//  scrollView-sample
//
//  Created by Yasin Akbaş on 20.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class FormView: UIView {
    
    private lazy var header: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: bounds.width, height: frame.height / 10 )
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: bounds.width / 2, height: 20)
        title.center = view.center
        title.text = "Add Item"
        title.textColor = .white
        title.textAlignment = .center
        title.font = UIFont.setFont(name: .avenirnextdemibold, size: 18)
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        view.addSubview(title)
        
        return view
    }()
    
    private lazy var itemNameTextField: FormTextField = {
        let textField = FormTextField()
        let width = bounds.width - 100
        textField.frame = CGRect(x: frame.midX - width / 2 , y: frame.height / 10 * 2, width: width, height: 40)
        textField.addPlaceholder(text: "Please enter item name")
        print(textField.frame)
        
        return textField
    }()
    
    private lazy var itemDescriptionTextField: FormTextField = {
        let textField = FormTextField()
        let width = bounds.width - 100
        textField.frame = CGRect(x: frame.midX - width / 2, y: (frame.height / 10) * 3, width: width, height: 40)
        print(textField.frame)
        textField.addPlaceholder(text: "Please enter item description")
        
        return textField
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        let width = bounds.width - 100
        button.frame = CGRect(x: frame.midX - width / 2, y: frame.height - 100, width: width, height: 50)
        button.setTitle("Add Item", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.8274509804, blue: 0.4117647059, alpha: 1), for: .normal)
        button.layer.borderColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.4117647059, alpha: 1)
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(clickedSubmitButton(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureMainView()
        addViews()
        makeConstraints()
        
    }
    
    private func addViews() {
        addSubview(header)
        addSubview(itemNameTextField)
        addSubview(itemDescriptionTextField)
        addSubview(submitButton)
    }
    
    private func configureMainView() {
        layer.cornerRadius = 0
        clipsToBounds = true
        backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        makeCornerRadius()
    }
    
    private func makeCornerRadius() {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .bottomRight],
            cornerRadii: CGSize(width: 30, height: 0.0)
        )

        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    private func makeConstraints() {
        
    }
    
    @objc func clickedSubmitButton(sender: UIButton) {
        print("button clicked")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
