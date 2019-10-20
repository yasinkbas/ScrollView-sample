//
//  ItemList.swift
//  scrollView-sample
//
//  Created by Yasin Akbaş on 19.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class ItemList: UIScrollView {
    
    var didSelectItem: ((_ index: Int)->())?
    
    private let pageWidth: CGFloat = UIScreen.main.bounds.width
    private let pageHeight: CGFloat = UIScreen.main.bounds.height
    private let padding: CGFloat = 10.0
    
    var totalPages: Int {
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
        
        alpha = 1
        
        for i in 0 ..< totalPages {
            
            //---------------------------- Page ----------------------------//
            let page = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: pageWidth - 40,
                                            height: pageHeight - 120)
            )
            page.center = CGPoint(x: CGFloat(i) * pageWidth + pageWidth/2, y: pageHeight/2)
            page.tag = i
            page.isUserInteractionEnabled = true
            
            page.layer.cornerRadius = 20
            page.clipsToBounds = true
            
            let gradient = CAGradientLayer()
            gradient.frame = page.bounds
            let custom1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 0.140437714).cgColor
            let custom2 = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.1358893408).cgColor
            gradient.colors = [custom1, custom2]
            page.layer.insertSublayer(gradient, at: 0)
            
            //---------------------------- Profile Photo ----------------------------//
            let profileWidth = page.frame.height / 7
            let profileView = UIView(frame: CGRect(x: page.frame.width / 2 - profileWidth / 2,
                                                   y: profileWidth / 3,
                                                   width: profileWidth,
                                                   height: profileWidth)
            )
            profileView.layer.cornerRadius = profileView.bounds.height / 2
            profileView.backgroundColor = .white
            page.addSubview(profileView)
            
            //---------------------------- Item name ----------------------------//
            let itemnameWidth = page.frame.width
            let itemname = UILabel(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: itemnameWidth,
                                                 height: 40)
            )
            itemname.center = profileView.center
            itemname.frame.origin.y = profileView.frame.maxY + 8
            itemname.text = "\(i). item"
            itemname.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 24)
            itemname.textColor = .white
            itemname.textAlignment = .center
            page.addSubview(itemname)
            
            //---------------------------- About Text Label ----------------------------//
            let aboutTextLabel = UILabel(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: page.frame.width - page.frame.width / 10,
                                                         height: page.frame.height / 2)
            )
            aboutTextLabel.backgroundColor = .clear
            aboutTextLabel.center = itemname.center
            aboutTextLabel.frame.origin.y = itemname.frame.maxY + 16
            aboutTextLabel.text = """
            What is Lorem Ipsum?
            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
            """
            aboutTextLabel.textColor = .white
            aboutTextLabel.adjustsFontSizeToFitWidth = true
            aboutTextLabel.numberOfLines = 0
            aboutTextLabel.minimumScaleFactor = 0.4
            aboutTextLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 16)
            page.addSubview(aboutTextLabel)
            
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
