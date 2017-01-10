//
//  PlaySoundsViewController.swift
//  Pitch-Perfect
//
//  Created by doohwan Lee on 2017. 1. 8..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var recordedAudioURL: URL!
    var timer : Timer?
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!

    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    @IBAction func normalPlay(_ sender: Any) {
    playSound()
        configureUI(.playing)
    }
    @IBAction func ChageSlider(_ sender: Any) {
        //audioFile.time
        //audioPlayerNode.self.time
        //audioPlayerNode.t
    }
    
    
    private func TotalTime() -> TimeInterval {
        if let nodeTime: AVAudioTime = audioPlayerNode.lastRenderTime, let playerTime: AVAudioTime = audioPlayerNode.playerTime(forNodeTime: nodeTime) {
            return Double(audioFile.length)/playerTime.sampleRate
        }
        return 0
    }
    private func currentTime() -> TimeInterval {
        if let nodeTime: AVAudioTime = audioPlayerNode.lastRenderTime, let playerTime: AVAudioTime = audioPlayerNode.playerTime(forNodeTime: nodeTime) {
            return Double(Double(playerTime.sampleTime) / playerTime.sampleRate)
        }
        return 0
    }
    func stringFromTimeInterval(_ interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        //let hours = (interval / 3600)
        return String(format: "%02d:%02d", minutes, seconds)
    }
    override func viewWillDisappear(_ animated: Bool) {
        stopAudio()
    }
    @IBAction func playSoundForButton(_ sender: UIButton) {
    print("play sound button pressed")
        switch (ButtonType(rawValue:sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
        totalTime.text = stringFromTimeInterval(TotalTime())
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update), userInfo: nil, repeats: true);
       
        
    }
    
    func update(){
        currentTimeLabel.text = stringFromTimeInterval(currentTime())
        slider.value = Float(currentTime()/TotalTime())
    }
    @IBAction func stopButtonPressed(_ sender: Any) {
    print("stop audio button pressed")
    stopAudio()
    timer = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        configureUI(.notPlaying)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = appDelegate.filename
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
