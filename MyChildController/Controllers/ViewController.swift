//
//  ViewController.swift
//  MyChildController
//
//  Created by trungnghia on 7/11/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Propeties
    private lazy var firstChildVC = FirstChildViewController()
    private lazy var secondChildVC = SecondChildViewController()
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.size.width * 2, height: 0)
        view.addSubview(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        addChildVCs()
    }
    
    // MARK: - Helpers
    private func addChildVCs() {
        addChild(firstChildVC)
        addChild(secondChildVC)
        
        scrollView.addSubview(firstChildVC.view)
        scrollView.addSubview(secondChildVC.view)
        
        firstChildVC.view.frame = CGRect(x: 0,
                                         y: 0,
                                         width: scrollView.frame.size.width,
                                         height: scrollView.frame.size.height)
        
        secondChildVC.view.frame = CGRect(x: scrollView.frame.size.width,
                                          y: 0,
                                          width: scrollView.frame.size.width,
                                          height: scrollView.frame.size.height)
        
        firstChildVC.didMove(toParent: self)
        secondChildVC.didMove(toParent: self)

    }

    // MARK: - IB Actions
    @IBAction func didChangeSegmentControllValue(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // first
            scrollView.setContentOffset(.zero, animated: true)
        } else {
            // second
            scrollView.setContentOffset(CGPoint(x: view.frame.size.width, y: 0), animated: true)
        }
    }
    
}

// MARK: - UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / view.bounds.size.width)
        segmentController.selectedSegmentIndex = index
        
    }
}
