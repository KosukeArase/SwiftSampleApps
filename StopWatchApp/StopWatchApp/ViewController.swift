//
//  ViewController.swift
//  StopWatchApp
//
//  Created by kosuke.arase on 2019/05/02.
//  Copyright © 2019 kosuke.arase. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var startTime: TimeInterval? = nil  // Double
    var timer = Timer()
    var elapsedTime: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonEnabled(start: true, stop: false, reset: false)
    }
    
    func setButtonEnabled(start: Bool, stop: Bool, reset: Bool) {
        self.startButton.isEnabled = start
        self.stopButton.isEnabled = stop
        self.resetButton.isEnabled = reset
    }
    
    @objc func update() {
        if let startTime = self.startTime {
            let t: Double = Date.timeIntervalSinceReferenceDate - startTime + self.elapsedTime
            let min = Int(t / 60)
            let sec = Int(t) % 60
            let msec = Int(t * 100) % 100
            self.timerLabel.text = String(format: "%02d:%02d:%02d", min, sec, msec)
        }
    }

    @IBAction func startTimer(_ sender: Any) {
        self.setButtonEnabled(start: false, stop: true, reset: false)
        self.startTime = Date.timeIntervalSinceReferenceDate
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)

    }

    @IBAction func stopTimer(_ sender: Any) {
        self.setButtonEnabled(start: true, stop: false, reset: true)
        if let startTime = self.startTime {
            self.elapsedTime += Date.timeIntervalSinceReferenceDate - startTime
        }
        self.timer.invalidate()
    }

    @IBAction func resetTimer(_ sender: Any) {
        self.setButtonEnabled(start: true, stop: false, reset: false)
        self.startTime = nil
        self.elapsedTime = 0
        self.timerLabel.text = "00:00:00"
    }

}

