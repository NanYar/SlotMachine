//
//  ViewController.swift
//  SlotMachine
//
//  Created by NanYar on 21.10.14.
//  Copyright (c) 2014 NanYar. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    var titleLabel: UILabel!
    
    let kMarginForView: CGFloat = 10.0
    let kSixth: CGFloat = 1.0 / 6.0
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupContainerViews()
        setupFirstContainer(firstContainer)
//        println(firstContainer.frame.height)
//        println(secondContainer.frame.height)
//        println(thirdContainer.frame.height)
//        println(fourthContainer.frame.height)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

    func setupContainerViews()
    {
        firstContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMarginForView, y: view.bounds.origin.y + (kMarginForView * 2), width: view.bounds.width - (kMarginForView * 2), height: view.bounds.height * kSixth - (kMarginForView * 2)))
        firstContainer.backgroundColor = UIColor.redColor()
        view.addSubview(firstContainer)
        
        secondContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + (kMarginForView * 2), width: view.bounds.width - (kMarginForView * 2), height: view.bounds.height * (3 * kSixth)))
        secondContainer.backgroundColor = UIColor.blackColor()
        view.addSubview(secondContainer)
        
        thirdContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + (kMarginForView * 2) + secondContainer.frame.height, width: view.bounds.width - (kMarginForView * 2), height: view.bounds.height * kSixth))
        thirdContainer.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(thirdContainer)
        
        fourthContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + (kMarginForView * 2) + secondContainer.frame.height + thirdContainer.frame.height, width: view.bounds.width - (kMarginForView * 2), height: view.bounds.height * kSixth))
        fourthContainer.backgroundColor = UIColor.blackColor()
        view.addSubview(fourthContainer)
    }
    
    func setupFirstContainer(containerView: UIView)
    {
        titleLabel = UILabel()
        titleLabel.text = "Super Slots"
        titleLabel.textColor = UIColor.yellowColor()
        titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        titleLabel.sizeToFit()
        titleLabel.center = CGPointMake(containerView.frame.width * 0.5, containerView.frame.height * 0.5)
        containerView.addSubview(titleLabel)
    }
}
