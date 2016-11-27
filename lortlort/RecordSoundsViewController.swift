//
//  RecordSoundsViewController.swift
//  lortlort
//
//  Created by CarlJohan on 25/11/16.
//  Copyright © 2016 Carl-Johan. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear was called")
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording in Progress"
        stopButton.isEnabled = true
        recordingButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
   
    @IBAction func stopRecording(_ sender: AnyObject) {
        recordingLabel.text = "Tap to record"
        recordingButton.isEnabled = true
        stopButton.isEnabled = false
    
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)

    }
}
