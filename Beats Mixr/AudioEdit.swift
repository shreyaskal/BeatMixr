//
//  AudioEdit.swift
//  Beats Mixr
//
//  Created by Shreyas Kalyan on 2/21/15.
//  Copyright (c) 2015 Shreyas Kalyan. All rights reserved.
//

import Foundation
import AVFoundation

class AudioEdit : UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    @IBOutlet var recordButton : UIButton!
    @IBOutlet var stopButton : UIButton!
    @IBOutlet var playButton : UIButton!

    lazy var soundFileURL: NSURL = {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths[0] as String
        let soundFilePath = docsDir.stringByAppendingPathComponent("audioRecording.mp4")
        return NSURL(fileURLWithPath: soundFilePath)!
    }()
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Audio Editor and Mixer"
        setup()
        
        let recordSettings = [AVFormatIDKey:kAudioFormatMPEG4AAC,
            AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
     
        var error: NSError?
        
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord,
            error: &error)
        
        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        }
        
        audioRecorder = AVAudioRecorder(URL: soundFileURL,
            settings: recordSettings, error: &error)

        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        } else {
            audioRecorder?.prepareToRecord()
        }
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        if audioRecorder?.recording == false {
            playButton.enabled = false
            stopButton.enabled = true
            audioRecorder?.record()
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        stopButton.enabled = false
        playButton.enabled = true
        recordButton.enabled = true
        
        audioRecorder?.stop()

    }
    
    @IBAction func playAudio(sender: UIButton) {
        if audioRecorder?.recording == false {
            stopButton.enabled = true
            recordButton.enabled = false
            
            var error: NSError?
            
            audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder?.url,
                error: &error)
            
            audioPlayer?.delegate = self
            
            if let err = error {
                println("audioPlayer error: \(err.localizedDescription)")
            } else {
                audioPlayer?.play()
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        recordButton.enabled = true
        stopButton.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        println("Audio Record Encode Error")
    }
    
    @IBAction func pushData(sender: UIButton){
        var audioFile = PFObject(className: "AudioRiff")
        var url = soundFileURL
        var data = NSData(contentsOfFile: soundFileURL.path!)
        println(data?.length)
        audioFile.setObject(data, forKey: "musicFile")
        audioFile.saveInBackgroundWithBlock{
            (success: Bool!, error: NSError!) -> Void in
        }
    }
    
    func setup(){
        self.view.backgroundColor = UIColorFromRGB(0xDB4D4D)
        
        recordButton.layer.cornerRadius = 5
        recordButton.layer.borderWidth = 1
        recordButton.layer.borderColor = UIColor.blackColor().CGColor
        stopButton.layer.cornerRadius = 5
        stopButton.layer.borderWidth = 1
        stopButton.layer.borderColor = UIColor.blackColor().CGColor
        playButton.layer.cornerRadius = 5
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.blackColor().CGColor
        
        recordButton.backgroundColor = UIColor.whiteColor()
        stopButton.backgroundColor = UIColor.whiteColor()
        playButton.backgroundColor = UIColor.whiteColor()
        
        playButton.enabled = false
        stopButton.enabled = false
        
    }


    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}