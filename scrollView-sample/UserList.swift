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
    
    
    let pageWidth: CGFloat = UIScreen.main.bounds.width
    let pageHeight: CGFloat = UIScreen.main.bounds.height
    let padding: CGFloat = 10.0
    
    var page: Int {
        get {
            return Int(padding)
        }
    }
    
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
        
        for i in 0 ..< page {
            
            //---------------------------- Page ----------------------------//
            let page = UIView(frame: CGRect(x: 0, y: 0, width: pageWidth - 40, height: pageHeight - 120))
            page.center = CGPoint(x: CGFloat(i) * pageWidth + pageWidth/2, y: pageHeight/2)
            page.tag = i
            page.isUserInteractionEnabled = true
            
            page.layer.cornerRadius = 20
            page.clipsToBounds = true
            
            let gradient = CAGradientLayer()
            gradient.frame = page.bounds
            let custom1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
            let custom2 = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
            gradient.colors = [custom1, custom2]
            page.layer.insertSublayer(gradient, at: 0)
            
            //---------------------------- Profile Photo ----------------------------//
            let profileWidth = page.frame.width / 3
            let profileView = UIView(frame: CGRect(x: page.frame.width / 2 - profileWidth / 2, y: 50, width: profileWidth, height: profileWidth))
            profileView.layer.cornerRadius = profileView.bounds.height / 2
            profileView.backgroundColor = .white
            page.addSubview(profileView)
            
            //---------------------------- Username ----------------------------//
            let usernameWidth = page.frame.width
            let username = UILabel(frame: CGRect(x: 0, y: 0, width: usernameWidth, height: 40))
            username.center = profileView.center
            username.frame.origin.y = profileView.frame.maxY + 8
            username.text = "\(i). user"
            username.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 24)
            username.textColor = .white
            username.textAlignment = .center
            page.addSubview(username)
            
            //---------------------------- TextView ----------------------------//
            let aboutTextView = UITextView(frame: CGRect(x: 0, y: 0, width: page.frame.width, height: page.frame.height / 2))
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
            page.addSubview(aboutTextView)
            
            addSubview(page)
            
            //---------------------------- Gesture ----------------------------//
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapPage(_:)))
            page.addGestureRecognizer(tap)
        }
        
        contentSize = CGSize(width: padding * pageWidth, height:  pageWidth )
    }
    
    //---------------------------- Gesture Func ----------------------------//
    @objc func didTapPage(_ tap: UITapGestureRecognizer) {
        didSelectItem?(tap.view!.tag)
    }
}
