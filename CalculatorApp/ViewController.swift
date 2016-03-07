//
//  ViewController.swift
//  CalculatorApp
//
//  Created by  on 2016-02-27.
//  Copyright © 2016 c. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        //case Equals = "="
        case Empty = "Empty"
        case Clear = "Clear"
    }

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftvalStr = ""
    var rightvalStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        }

    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    @IBAction func onDividePress(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPress(sender: AnyObject) {
        
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPress(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPress(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPress(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    
    @IBAction func onClearPress(sender: AnyObject) {
        playSound()
        leftvalStr = ""
        rightvalStr = ""
        outputLbl.text = "0000"
        runningNumber = ""
        currentOperation = Operation.Empty
        //processOperation(Operation.Clear)
    }
    
    func processOperation(op : Operation){
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightvalStr = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftvalStr)! * Double(rightvalStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftvalStr)! / Double(rightvalStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftvalStr)! + Double(rightvalStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftvalStr)! - Double(rightvalStr)!)"
                }
                
                leftvalStr = result
                
                outputLbl.text = result
            }
           
            
            currentOperation = op
            
            //
        } else {
            leftvalStr = runningNumber
            runningNumber = ""
            currentOperation = op 
        }
        
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        
        btnSound.play()
    }
}

