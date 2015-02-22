//
//  ViewController.swift
//  Beats Mixr
//
//  Created by Shreyas Kalyan on 2/21/15.
//  Copyright (c) 2015 Shreyas Kalyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MXClientChatDelegate{
    
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var selectAudio: UIButton!
    @IBOutlet var killData : UIButton!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setup()
    }
    
    @IBAction func clearData(sender:UIButton){
        var query = PFQuery(className:"AudioRiff")
        PFObject.deleteAll(query.findObjects())
        
    }
    
    func setup(){
        self.view.backgroundColor = UIColorFromRGB(0x003366);
        
        
        
        titleLabel.text = "Welcome to Beats Mixr!"
        titleLabel.textColor = UIColorFromRGB(0xFFCC66)
        titleLabel.textAlignment = NSTextAlignment.Center;
        
        let createChatButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton;
        createChatButton.setTitle("Create Chat", forState: UIControlState.Normal);
        createChatButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        createChatButton.sizeToFit();
        createChatButton.addTarget(self, action: "createChat", forControlEvents: UIControlEvents.TouchUpInside);
        let createChatButtonItem = UIBarButtonItem(customView: createChatButton as UIView);
        self.navigationItem.rightBarButtonItem = createChatButtonItem;
        
        //Set Moxtra chat delegate
        Moxtra.sharedClient().delegate = self;

    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    func createChat() {
        
        Moxtra.sharedClient().createChat("chat1", inviteMembersUniqueID: nil, success: { (binderID:String!, chatViewController:UIViewController!) -> Void in
            self.presentViewController(chatViewController, animated: true, completion: nil)
            }, failure: nil);
    }
    
    
    func popChatViewController(chatViewController: UIViewController!) {
        chatViewController.dismissViewControllerAnimated(true, completion: nil);
    }

}

