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
    
    // Information Labels
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    
    // Buttons in fourth container
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!
    
    var slots: [[Slot]] = []
    
    // Stats:
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    let kMarginForView: CGFloat = 10.0
    let kMarginForSlot: CGFloat = 2.0
    let kSixth: CGFloat = 1.0 / 6.0
    let kThird: CGFloat = 1.0 / 3.0
    let kHalf: CGFloat = 1.0 / 2.0
    let kEighth: CGFloat = 1.0 / 8.0
    
    let kNumberOfContainers = 3 // columns
    let kNumberOfSlots = 3 // rows
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupContainerViews()
        setupFirstContainer(firstContainer)
        setupThirdContainer(thirdContainer)
        setupFourthContainer(fourthContainer)
        hardReset() // sets up also secondContainer
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    // IBActions
    func resetButtonPressed(button: UIButton)
    {
        hardReset()
    }
    
    func betOneButtonPressed(button: UIButton)
    {
        if credits <= 0
        {
            showAlertWithText(header: "No More Credits", message: "Reset Game")
        }
        else
        {
            if currentBet < 5
            {
                currentBet += 1
                credits -= 1
                updateMainView()
            }
            else
            {
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
    }
    
    func betMaxButtonPressed(button: UIButton)
    {
        if credits < 5
        {
            showAlertWithText(header: "Not Enought Credits", message: "Bet less!")
        }
        else
        {
            if currentBet < 5
            {
                var creditsToBetMax = 5 - currentBet
                credits -= creditsToBetMax
                currentBet += creditsToBetMax
                updateMainView()
            }
            else
            {
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
    }
    
    func spinButtonPressed(button: UIButton)
    {
        removeSlotImageViews()
        slots = Factory.createSlots()
        setupSecondContainer(secondContainer)
        
        var winningsMultiplier = SlotBrain.computeWinnings(slots)
        winnings = winningsMultiplier * currentBet
        credits += winnings
        currentBet = 0
        updateMainView()
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
    
    func setupSecondContainer(containerView: UIView)
    {
        for var containerNumber = 0; containerNumber < kNumberOfContainers; containerNumber++ // columns
        {
            for var slotNumber = 0; slotNumber < kNumberOfSlots; slotNumber++ // rows
            {
                var slot: Slot
                var slotImageView = UIImageView()
                
                if slots.count != 0 // = Spin button pressed
                {
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                }
                else
                {
                    slotImageView.image = UIImage(named: "Ace") // = viewDidLoad
                }
                
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * kThird), y: containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(slotNumber) * kThird), width: containerView.bounds.width * kThird - kMarginForSlot, height: containerView.bounds.height * kThird - kMarginForSlot)
                containerView.addSubview(slotImageView)
            }
        }
    }
    
    func setupThirdContainer(containerView: UIView)
    {
        creditsLabel = UILabel()
        creditsLabel.text = "000000"
        creditsLabel.textColor = UIColor.redColor()
        creditsLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        creditsLabel.sizeToFit()
        creditsLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird)
        creditsLabel.textAlignment = NSTextAlignment.Center
        creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(creditsLabel)
        
        betLabel = UILabel()
        betLabel.text = "0000"
        betLabel.textColor = UIColor.redColor()
        betLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        betLabel.sizeToFit()
        betLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird)
        betLabel.textAlignment = NSTextAlignment.Center
        betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(betLabel)
        
        winnerPaidLabel = UILabel()
        winnerPaidLabel.text = "000000"
        winnerPaidLabel.textColor = UIColor.redColor()
        winnerPaidLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        winnerPaidLabel.sizeToFit()
        winnerPaidLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird)
        winnerPaidLabel.textAlignment = NSTextAlignment.Center
        winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(winnerPaidLabel)
        
        creditsTitleLabel = UILabel()
        creditsTitleLabel.text = "Credits"
        creditsTitleLabel.textColor = UIColor.blackColor()
        creditsTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        creditsTitleLabel.sizeToFit()
        creditsTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird * 2)
//      creditsTitleLabel.textAlignment = NSTextAlignment.Center
//      creditsTitleLabel.backgroundColor = UIColor.lightGrayColor()
        containerView.addSubview(creditsTitleLabel)
        
        betTitleLabel = UILabel()
        betTitleLabel.text = "Bet"
        betTitleLabel.textColor = UIColor.blackColor()
        betTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        betTitleLabel.sizeToFit()
        betTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(betTitleLabel)
        
        winnerPaidTitleLabel = UILabel()
        winnerPaidTitleLabel.text = "Winner Paid"
        winnerPaidTitleLabel.textColor = UIColor.blackColor()
        winnerPaidTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        winnerPaidTitleLabel.sizeToFit()
        winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(winnerPaidTitleLabel)
    }
    
    func setupFourthContainer(containerView: UIView)
    {
        resetButton = UIButton()
        resetButton.setTitle("Reset", forState: UIControlState.Normal)
        resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        resetButton.backgroundColor = UIColor.lightGrayColor()
        resetButton.sizeToFit()
        resetButton.center = CGPoint(x: containerView.frame.width * kEighth, y: containerView.frame.height * kHalf)
        resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(resetButton)
        
        betOneButton = UIButton()
        betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        betOneButton.backgroundColor = UIColor.greenColor()
        betOneButton.sizeToFit()
        betOneButton.center = CGPoint(x: containerView.frame.width * kEighth * 3, y: containerView.frame.height * kHalf)
        betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betOneButton)
        
        betMaxButton = UIButton()
        betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        betMaxButton.backgroundColor = UIColor.redColor()
        betMaxButton.sizeToFit()
        betMaxButton.center = CGPoint(x: containerView.frame.width * kEighth * 5, y: containerView.frame.height * kHalf)
        betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betMaxButton)
        
        spinButton = UIButton()
        spinButton.setTitle("Spin", forState: UIControlState.Normal)
        spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        spinButton.backgroundColor = UIColor.greenColor()
        spinButton.sizeToFit()
        spinButton.center = CGPoint(x: containerView.frame.width * kEighth * 7, y: containerView.frame.height * kHalf)
        spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(spinButton)
    }
    
    func removeSlotImageViews()
    {
        if secondContainer != nil // = optional test
        {
            let container: UIView? = secondContainer // = required test
            let subViews: Array? = container!.subviews
            for view in subViews!
            {
                view.removeFromSuperview()
            }
        }
    }
    
    func hardReset()
    {
        removeSlotImageViews()
        slots.removeAll(keepCapacity: true)
        setupSecondContainer(secondContainer)
        credits = 20
        currentBet = 0
        winnings = 0
        
        updateMainView()
    }
    
    func updateMainView()
    {
        creditsLabel.text = String(credits)
        betLabel.text = String(currentBet)
        winnerPaidLabel.text = String(winnings)
    }
    
    func showAlertWithText(header: String = "Warning", message: String)
    {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}







