//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by ferddy on 3/24/15.
//  Copyright (c) 2015 ferddy. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    func audioSpeed(speed: Float){
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0
        audioPlayer.play()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
    audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
    audioPlayer.enableRate = true
    
    audioEngine = AVAudioEngine()
    audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        audioSpeed(0.5)
        audioEngine.stop()
        audioEngine.reset()    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioSpeed(2)
        audioEngine.stop()
        audioEngine.reset()
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
