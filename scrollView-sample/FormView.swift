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
        view.frame = CGRect(x: 0, y: 0, width: bounds.width, height: (UIScreen.main.bounds.height - 300) / 12)
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: bounds.width / 2, height: 20)
        title.center = view.center
        print("title frame",title.frame)
        print("view frame",view.frame)
        title.text = "Add Item"
        title.textColor = .white
        title.textAlignment = .center
        title.font = UIFont(name: "avenirnext-demibold", size: 18)
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        view.addSubview(title)
        return view
    }()
    
    private lazy var itemNameTextField: FormTextField = {
        let textField = FormTextField()
        textField.frame.size = CGSize(width: frame.width / 1.5, height: 30)
        textField.center = center
        textField.placeholder = "Please enter item name"
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainView()
        addViews()
    }
    
    private func addViews() {
        addSubview(header)
        addSubview(itemNameTextField)
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
            cornerRadii: CGSize(width: 30, height: 0.0))

        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
