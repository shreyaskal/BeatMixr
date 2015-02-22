//
//  SoundMixerViewController.swift
//  Beats Mixr
//
//  Created by Shreyas Kalyan on 2/21/15.
//  Copyright (c) 2015 Shreyas Kalyan. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class SoundMixerViewController : UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var file: [NSData] = []
    var audioPlayer : AVAudioPlayer?
    override func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
        return file.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        var ind = 1 + (indexPath.row)
        cell.textLabel?.text = "Beat # \(ind)"
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var error: NSError?
        audioPlayer = AVAudioPlayer(data: file[indexPath.item], error: &error)
        audioPlayer?.numberOfLoops = 10
        audioPlayer?.play()
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func viewDidLoad() {
        recieveData()
        super.viewDidLoad()
        self.navigationItem.title = "Loop other's Beats";
        self.view.backgroundColor = UIColorFromRGB(0x003366);

        
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func recieveData() {
        var query = PFQuery(className:"AudioRiff")
        var list = query.findObjects()
                for i in list {
            file.append(i.objectForKey("musicFile") as NSData)
        }
    }

    
    
    
    
}

