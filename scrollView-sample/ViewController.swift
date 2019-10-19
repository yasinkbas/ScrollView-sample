//
//  ViewController.swift
//  scrollView-sample
//
//  Created by Yasin Akbaş on 19.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var slider: UserList!
    var pageControl: UIPageControl!
    
    var safeGuide: UILayoutGuide!
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        imageView.image = #imageLiteral(resourceName: "background")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var menuView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return view
    }()

    
    //---------------------------- View lifecycle ----------------------------//
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImage)
        
        safeGuide = view.layoutMarginsGuide
        makeSlider()
        setUpMenuView()
        makePageControl()
        
    }
    
    //---------------------------- Menu View ----------------------------//
    func setUpMenuView() {
        self.view.addSubview(menuView)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.menuView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        self.menuView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        self.menuView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        
    }
    
    //---------------------------- Make Slider ----------------------------//
    func makeSlider() {
        slider = UserList(inView: view)
        slider.didSelectItem = { index in
            print(index)
        }
        slider.isScrollEnabled = true
        slider.delegate = self
        view.addSubview(slider)
    }
    
    //---------------------------- Page control ----------------------------//
    func makePageControl() {
        let pageControlWidth = view.frame.width / 3
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: pageControlWidth, height: 20))
        pageControl.frame.origin = CGPoint(x: view.frame.midX - pageControlWidth / 2, y: view.frame.maxY - 30)
        pageControl.numberOfPages = 10
        pageControl.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.989929378, green: 0.8843280673, blue: 0.1261277199, alpha: 1)
        
        view.addSubview(pageControl)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(slider.contentOffset.x / slider.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        print("worked")
    }
}

