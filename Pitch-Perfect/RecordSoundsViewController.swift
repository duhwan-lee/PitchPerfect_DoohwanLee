//
//  ViewController.swift
//  Test02
//
//  Created by doohwan Lee on 2017. 1. 2..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    var timer : Timer!
    var sec = 0;
    @IBOutlet weak var recordingTime: UILabel!
    var audioRecorder: AVAudioRecorder!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear called")
        sec = 0
        recordingTime.text = "00:00"
        
    }

    @IBAction func nameChgange(_ sender: Any) {
        let dialog = UIAlertController(title: "파일 입력", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            print("OK click")
            let userInput = dialog.textFields![0]
            self.appDelegate.filename = (userInput.text)!
        }
        let cancleAction = UIAlertAction(title: "취소", style: .default) { (UIAlertAction) in
            print("cancle click")
        }
        //dialog.textFields?[0]
        dialog.addAction(okAction)
       dialog.addAction(cancleAction)
        dialog.addTextField(configurationHandler: { (textField : UITextField) in
            // 키보드 설정
            textField.text = self.appDelegate.filename

            textField.keyboardType = .default
            
        })
        self.present(dialog, animated: true, completion: nil)
        print("ok")
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        //let recordingName = "recordedVoice.wav"
        
        let pathArray = [dirPath, appDelegate.filename+".wav"]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        //print(filePath!)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true);
        
    }
    func stringFromTimeInterval(_ interval: Int) -> String {
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func update(){
        sec += 1
        recordingTime.text = stringFromTimeInterval(sec)
        UIButton.animate(withDuration: 0.5, delay : 0.0,
                         options: .allowUserInteraction ,
                         animations: {self.stopRecordingButton.alpha = CGFloat.init(0.3)},
                         completion:
            {(finished) in
                UIButton.animate(withDuration: 0.5, delay : 0.0,
                                 options: .allowUserInteraction ,
                                 animations: {self.stopRecordingButton.alpha = CGFloat.init(1.0)})
        })
        
    }
    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        timer.invalidate()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("finished recording")
        if flag {
            appDelegate.recordAudioURL = audioRecorder.url
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)

        }else{
            print("recording was not successful")
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "stopRecording"{
//            let playSoundVC = segue.destination as! PlaySoundsViewController
//            let recordedAudioURL = sender as! URL
//            playSoundVC.recordedAudioURL = recordedAudioURL
//        }
//    }
}
