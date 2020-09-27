//
//  ViewController.swift
//  timer_app
//
//  Created by Mouhamed Camara on 9/15/20.
//  Copyright © 2020 PayDunya. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    //MARK: Outlets
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startTimerButton: UIButton!
    
    @IBOutlet weak var stopTimerButton: UIButton!
    
    @IBOutlet weak var resumeButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    //MARK: Actions
    
    @IBAction func startCounterButtonAct(_ sender: UIButton)
    {
        startTimerButton.isHidden = true
        stopTimerButton.isHidden = false
        resetButton.isHidden = true
        resumeButton.isHidden = true
        
        status = .start
        
        shudle()
    }
    
    @IBAction func stopCounterButtonAct(_ sender: UIButton)
    {
        resetButton.isHidden = false
        resumeButton.isHidden = false
        startTimerButton.isHidden = true
        stopTimerButton.isHidden = true
        
        status = .stop
        shudle()
    }
    
    @IBAction func resumeCounterButtonAct(_ sender: UIButton)
    {
        resetButton.isHidden = true
        resumeButton.isHidden = true
        startTimerButton.isHidden = true
        stopTimerButton.isHidden = false
        
        status = .resume
        shudle()
    }
    
    @IBAction func resetCounterButtonAct(_ sender: UIButton)
    {
        startTimerButton.isHidden = false
        resetButton.isHidden = true
        resumeButton.isHidden = true
        stopTimerButton.isHidden = true
        
        status = .reset
        shudle()
    }
    
    //MARK: Properties

    var status: Status = Status.stop
        
    var timer = Timer()
    
    var seconds = 0
    
    var second = 0
    
    var minute = 0
    
    var hour = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        timerLabel.layer.cornerRadius = timerLabel.frame.size.height / 2
        timerLabel.layer.borderColor = UIColor.orange.cgColor
        timerLabel.layer.borderWidth = 2.5
    }
    
    //MARK: Functions
    
    func shudle()
    {
        print(status)
        switch status
        {
            case .start:
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startTimer), userInfo: nil, repeats: true)
            case .stop:
                timer.invalidate()
                stopTimer()
            case .resume:
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startTimer), userInfo: nil, repeats: true)
            case .reset:
                timer.invalidate()
                resetTimer()
        }
    }
    
    func stopTimer()
    {
        minute = seconds / 60
        second = seconds % 60
        hour = minute / 60
        
        if minute < 10 && second < 10
        {
            timerLabel.text = "\(hour):0\(minute):0\(second)"
        }
        else if minute < 10
        {
            timerLabel.text = "\(hour):0\(minute):\(second)"
        }
        else
        {
            timerLabel.text = "\(hour):\(minute):0\(second)"
        }

    }
    
    func resetTimer()
    {
        timerLabel.text = "0:00:00"
        
        seconds = 0
    }
    
    @objc func startTimer()
    {
        print("\(seconds)")
        
        seconds += 1
        second = seconds
        
        minute = seconds / 60
        second = seconds % 60
        hour = minute / 60
        
        if minute < 10 && second < 10
        {
            timerLabel.text = "\(hour):0\(minute):0\(second)"
        }
        else if minute < 10
        {
            timerLabel.text = "\(hour):0\(minute):\(second)"
        }
        else
        {
            timerLabel.text = "\(hour):\(minute):0\(second)"
        }
    }
    
    //MARK: Enum
    
    enum Status
    {
        case start
        case stop
        case resume
        case reset
    }

}

