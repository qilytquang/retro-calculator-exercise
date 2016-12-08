//
//  ViewController.swift
//  exercise_RetroCalculator
//
//  Created by quang nguyen on 12/8/16.
//  Copyright © 2016 quang nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = "0"
    var rightVarStr = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    @IBAction func numberBtnPressed(sender: UIButton) {
        playSound()
        
        if runningNumber == "0" {
            runningNumber = ""
        }
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func divideBtnPressed(sender: AnyObject) {
        playSound()
        
        processOperator(operation: .Divide)
    }
    
    @IBAction func multiplyBtnPressed(sender: AnyObject) {
        playSound()
        
        processOperator(operation: .Multiply)
    }
    
    @IBAction func substractBtnPressed(sender: AnyObject) {
        playSound()
        
        processOperator(operation: .Subtract)
    }
    
    @IBAction func addBtnPressed(sender: AnyObject) {
        playSound()
        
        processOperator(operation: .Add)
    }
    
    @IBAction func equalBtnPressed(sender: AnyObject) {
        playSound()
        
        processOperator(operation: .Empty)
    }
    
    @IBAction func clearBtnPressed(sender: AnyObject) {
        playSound()
        
        //reset into default values
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValStr = "0"
        rightVarStr = ""
        result = ""
        
        outputLbl.text = leftValStr
    }
    
    func processOperator(operation: Operation) {
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightVarStr = runningNumber
                runningNumber = ""
                
                switch currentOperation {
                case .Divide:
                    result = "\(Double(leftValStr)! / Double(rightVarStr)!)"
                case .Multiply:
                    result = "\(Double(leftValStr)! * Double(rightVarStr)!)"
                case .Subtract:
                    result = "\(Double(leftValStr)! - Double(rightVarStr)!)"
                case .Add:
                    result = "\(Double(leftValStr)! + Double(rightVarStr)!)"
                case .Empty:
                    //nothing need to do
                    break
                }
                
                leftValStr = result
                outputLbl.text = result
                
            } else {
                // no number is pressed after operation button is pressed, therefore we just need to update currentOperator
            }
            
            currentOperation = operation
        } else {
            //the first time operator pressed
            
            if runningNumber != "" {
                leftValStr = runningNumber
                runningNumber = ""
            }
            
            currentOperation = operation
        }
    }

}

