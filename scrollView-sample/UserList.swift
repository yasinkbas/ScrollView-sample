//
//  UserList.swift
//  scrollView-sample
//
//  Created by Yasin Akbaş on 19.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class UserList: UIScrollView {
    
    var didSelectItem: ((_ index: Int)->())?
    
    let buttonWidth: CGFloat = UIScreen.main.bounds.width
    let buttonHeight: CGFloat = UIScreen.main.bounds.height
    let padding: CGFloat = 30.0
    
    required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    }
    
    convenience init (inView: UIView) {
        let rect = CGRect(x: 0, y: 40, width: inView.frame.width, height: inView.frame.height - 40)
        self.init(frame: rect)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        isPagingEnabled = true
        
        alpha = 0.85
        
        for i in 0 ..< 30 {
            
            //---------------------------- Page ----------------------------//
            let item = UIView(frame: CGRect(x: 0, y: 0, width: buttonWidth - 40, height: buttonHeight - 120))
            item.center = CGPoint(x: CGFloat(i) * buttonWidth + buttonWidth/2, y: buttonHeight/2)
            item.tag = i
            item.isUserInteractionEnabled = true
            
            item.layer.cornerRadius = 20
            item.clipsToBounds = true
            
            let gradient = CAGradientLayer()
            gradient.frame = item.bounds
            let custom1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
            let custom2 = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
            gradient.colors = [custom1, custom2]
            item.layer.insertSublayer(gradient, at: 0)
            
            //---------------------------- Profile Photo ----------------------------//
            let profileWidth = item.frame.width / 3
            let profileView = UIView(frame: CGRect(x: item.frame.width / 2 - profileWidth / 2, y: 50, width: profileWidth, height: profileWidth))
            profileView.layer.cornerRadius = profileView.bounds.height / 2
            profileView.backgroundColor = .white
            item.addSubview(profileView)
            
            //---------------------------- Username ----------------------------//
            let usernameWidth = item.frame.width
            let username = UILabel(frame: CGRect(x: 0, y: 0, width: usernameWidth, height: 40))
            username.center = profileView.center
            username.frame.origin.y = profileView.frame.maxY + 8
            username.text = "\(i). user"
            username.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 24)
            username.textColor = .white
            username.textAlignment = .center
            item.addSubview(username)
            
            //---------------------------- TextView ----------------------------//
            let aboutTextView = UITextView(frame: CGRect(x: 0, y: 0, width: item.frame.width, height: item.frame.height / 2))
            aboutTextView.backgroundColor = .clear
            aboutTextView.center = username.center
            aboutTextView.frame.origin.y = username.frame.maxY + 16
            aboutTextView.text = """
            What is Lorem Ipsum?
            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
            """
            aboutTextView.textColor = .white
            aboutTextView.font = UIFont(name: "AvenirNextCondensed-Regular", size: 14)
            aboutTextView.isUserInteractionEnabled = false
            item.addSubview(aboutTextView)
            
            addSubview(item)
            //---------------------------- Gesture ----------------------------//
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage(_:)))
            item.addGestureRecognizer(tap)
        }
        
        contentSize = CGSize(width: padding * buttonWidth, height:  buttonWidth )
    }
    
    //---------------------------- Gesture Func ----------------------------//
    @objc func didTapImage(_ tap: UITapGestureRecognizer) {
        didSelectItem?(tap.view!.tag)
    }
}
