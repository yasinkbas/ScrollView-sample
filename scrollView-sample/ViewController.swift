//
//  ViewController.swift
//  scrollView-sample
//
//  Created by Yasin Akbaş on 19.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var slider: ItemList!
    var pageControl: UIPageControl!
    var form: FormView!
    
    var safeGuide: UILayoutGuide!
    
    var addButtonClicked = false
    
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
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.titleLabel?.textColor = .white
        
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    //---------------------------- AddButton ----------------------------//
    @objc func addButtonPressed(sender: UIButton) {
        addButtonClicked = !addButtonClicked
        
        // button animation
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.curveEaseInOut,.allowUserInteraction],
            animations: {
                let angle: CGFloat = self.addButtonClicked ? .pi / 4 : 0.0
                self.addButton.transform = CGAffineTransform(rotationAngle: angle)
                self.view.layoutIfNeeded()
        },
            completion: nil
        )
        
        // form animation
        if addButtonClicked {
            form.isHidden = false
            self.form.frame.origin.x = self.view.bounds.width / 2 - self.form.bounds.width / 2
            self.form.frame.origin.y = -self.form.frame.height
            view.addSubview(form)
            UIView.animate(
                withDuration: 0.4,
                delay: 0.3,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 10,
                options: .curveEaseOut,
                animations: {
                    self.form.center = self.view.center
            },
                completion: nil
            )
        } else {
            UIView.animate(
                withDuration: 0.4,
                delay: 0.3,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 10,
                options: .curveEaseIn,
                animations: {
                    self.form.frame.origin.y = -self.form.frame.height
            },
                completion: { _ in
                    self.form.removeFromSuperview()
            })
        }        
    }

    // MARK: - View
    //---------------------------- View lifecycle ----------------------------//
    override func viewDidLoad() {
        super.viewDidLoad()
        safeGuide = view.layoutMarginsGuide
        
        // backgroundImage
        view.addSubview(backgroundImage)
        
        // slider
        makeSlider()
        
        // page control for slider
        makePageControl()
        
        // menuView
        view.addSubview(menuView)
        setUpMenuViewConstraints()
        
        // add button
        view.addSubview(addButton)
        setUpAddButtonConstraints()
        
        // form
        makeForm()
        
    }
    // MARK: - Constraints
    //---------------------------- Menu View Constraints ----------------------------//
    func setUpMenuViewConstraints() {
        
    }
    
    //---------------------------- Add Button Constraints ----------------------------//
    func setUpAddButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 16).isActive = true
    }
    
    // MARK: - Make
    
    //---------------------------- Make Form ----------------------------//
    func makeForm() {
        form = FormView()
        form.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 50, height: view.bounds.height - 300)
        form.backgroundColor = .white
        form.isHidden = true
        form.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(form)
    }
    
    //---------------------------- Make Slider ----------------------------//
    func makeSlider() {
        slider = ItemList(inView: view)
        slider.didSelectItem = { index in
            print(index)
        }
        slider.isScrollEnabled = true
        slider.delegate = self
        view.addSubview(slider)
    }
    
    //---------------------------- Make Page control ----------------------------//
    func makePageControl() {
        let pageControlWidth = view.frame.width / 3
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: pageControlWidth, height: 20))
        pageControl.frame.origin = CGPoint(x: view.frame.midX - pageControlWidth / 2, y: view.frame.maxY - 30)
        pageControl.numberOfPages = slider.totalPages
        pageControl.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.9771235585, green: 0.9493796229, blue: 0, alpha: 1)
        
        view.addSubview(pageControl)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(slider.contentOffset.x / slider.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}

