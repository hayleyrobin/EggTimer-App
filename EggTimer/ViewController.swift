//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

     let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 600]

    var timer = Timer()
    var alarm: AVAudioPlayer!
    
    // keep track of seconds
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {

        timer.invalidate() // stops|cancels timer to create new one when button is tapper
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        // timeInterval : how often time fires (every second
        // selector: calls func every time second fires
        // repeat: doesnt stop after the 1 second
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }

    @objc func updateTimer() {
        if(secondsPassed < totalTime) {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)

            progressBar.progress = Float(percentageProgress)


        }
        else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playAlarm()
        }
       
    }
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        alarm = try! AVAudioPlayer(contentsOf: url!) // load sound
        alarm.play()
                
    }
}
