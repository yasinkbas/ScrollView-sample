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
    
    private lazy var formBackgroundView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 70, width: self.view.frame.width, height: self.view.frame.height)
        print(view.frame)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)
        view.alpha = 0.0
        
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        imageView.image = #imageLiteral(resourceName: "background")
        imageView.contentMode = .scaleToFill
        print(imageView.frame, "imageView")
        
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
        
        rotateAddButton()
        popForm()
    }
    
    func popForm() {
        if addButtonClicked {
            form.isHidden = false
            self.form.frame.origin.x = self.view.bounds.width / 2 - self.form.bounds.width / 2
            self.form.frame.origin.y = self.view.bounds.height + self.form.bounds.height
            view.addSubview(form)
            UIView.animate(
                withDuration: 0.5,
                delay: 0.0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.0,
                options: .curveEaseOut,
                animations: {
                    self.form.center = self.view.center
                    self.formBackgroundView.alpha = 1
            },
                completion: nil
            )
        } else {
            UIView.animate(
                withDuration: 0.35,
                delay: 0.0,
                usingSpringWithDamping: 1.0,
                initialSpringVelocity: 0.0,
                options: .curveEaseIn,
                animations: {
                    self.form.frame.origin.y = self.view.bounds.height + self.form.bounds.height
                    self.formBackgroundView.alpha = 0.0
            },
                completion: { _ in
                    self.form.removeFromSuperview()
            })
        }
    }
    
    func rotateAddButton() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                let angle: CGFloat = self.addButtonClicked ? .pi / 4 : 0.0
                let scale: CGFloat = self.addButtonClicked ? 1.3 : 1.0
                self.addButton.transform = CGAffineTransform(rotationAngle: angle)
                    .concatenating(CGAffineTransform(scaleX: scale, y: scale))
                self.view.layoutIfNeeded()
        },
            completion: nil
        )
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
        
        // darker view
        view.addSubview(formBackgroundView)
        
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
        
        form = FormView(frame: CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width / 1.1 ,
            height: view.bounds.height / 1.4
        ))
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

