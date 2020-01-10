//
//  ViewController.swift
//  Hapy_Math
//
//  Created by nhp on 2/6/19.
//  Copyright © 2019 nhp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mathP2: UILabel!
    @IBOutlet weak var timeP2: UILabel!
    @IBOutlet weak var scoreP2: UILabel!
    @IBOutlet weak var answer21: UIButton!
    @IBOutlet weak var answer22: UIButton!
    @IBOutlet weak var answer23: UIButton!
    // finish all elements of person 2 (host)
    
    @IBOutlet weak var mathP1: UILabel!
    @IBOutlet weak var timeLabelP1: UILabel!
    @IBOutlet weak var scoreLabelP1: UILabel!
    @IBOutlet weak var timeP1: UILabel!
    @IBOutlet weak var scoreP1: UILabel!
    @IBOutlet weak var answer11: UIButton!
    @IBOutlet weak var answer12: UIButton!
    @IBOutlet weak var answer13: UIButton!
    // finish all elements of person 1 (guest)
    
    var math = Math()
    var mathExpression = [String]()
    var mathExpressionIndexP2 = Int(0)
    var mathExpressionIndexP1 = Int(0)
    var mathResult2 = String()
    var mathResult1 = String()
    var timer1 = Timer()
    var timer2 = Timer()
    var counter1 = 0
    var counter2 = 0
    let limitNumberOfMathExpression = 10
    let scoreOfOneMath = 30
    let limitTimeOfOneMath = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.timeLabelP1.transform = self.timeLabelP1.transform.rotated(by: CGFloat(Double.pi))
        self.timeP1.transform = self.timeP1.transform.rotated(by: CGFloat(Double.pi))
        self.mathP1.transform = self.mathP1.transform.rotated(by: CGFloat(Double.pi))
        self.scoreLabelP1.transform = self.scoreLabelP1.transform.rotated(by: CGFloat(Double.pi))
        self.scoreP1.transform = self.scoreP1.transform.rotated(by: CGFloat(Double.pi))
        self.answer11.transform = self.answer11.transform.rotated(by: CGFloat(Double.pi))
        self.answer12.transform = self.answer12.transform.rotated(by: CGFloat(Double.pi))
        self.answer13.transform = self.answer13.transform.rotated(by: CGFloat(Double.pi))
        
    }
    
    @IBAction func pressPlayGame(_ sender: UIButton) {
        if(answer12.titleLabel?.text == "Start"){
            mathExpressionIndexP1 = 0
            mathExpressionIndexP2 = 0
            scoreP1.text = "0"
            scoreP2.text = "0"
            counter1 = 0
            counter2 = 0
            // reset score, time and math index when press start again
            let numberOfMathExpression:Int = limitNumberOfMathExpression / 2
            mathExpression = math.createExpression(numberOfMath: numberOfMathExpression)
            print(mathExpression)
            mathP1.text = mathExpression[mathExpressionIndexP1]
            mathExpressionIndexP1 = mathExpressionIndexP1 + 1
            mathP2.text = mathExpression[mathExpressionIndexP2]
            mathExpressionIndexP2 = mathExpressionIndexP2 + 1
            mathResult1 = mathExpression[mathExpressionIndexP1]
            mathResult2 = mathResult1
            mathExpressionIndexP1 = mathExpressionIndexP1 + 1
            mathExpressionIndexP2 = mathExpressionIndexP2 + 1
            var mathResult1Int = Int(mathResult1)! - 1
            var mathAnswerArray = [String]()
            mathAnswerArray.append(mathResult1)
            mathAnswerArray.append(String(mathResult1Int))
            mathResult1Int = Int(mathResult1)! + 1
            mathAnswerArray.append(String(mathResult1Int))
            mathAnswerArray.shuffle()
            // shuffle element in array
            answer11.setTitle(mathAnswerArray[0], for: .normal)
            answer23.setTitle(mathAnswerArray[0], for: .normal)
            
            answer12.setTitle(mathAnswerArray[1], for: .normal)
            answer21.setTitle(mathAnswerArray[1], for: .normal)
            
            answer22.setTitle(mathAnswerArray[2], for: .normal)
            answer13.setTitle(mathAnswerArray[2], for: .normal)
            
            
            // the first question have same result for both players
            startTime1()
            startTime2()
        }
        
        
    }
    
    func startTime1() {
        timer1.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        let interval:TimeInterval = 1
        timer1 = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(timerAction1), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction1() {
        counter1 += 1
        timeP1.text = "\(counter1)"
        if(counter1 > limitTimeOfOneMath){
            if(mathExpressionIndexP1 < limitNumberOfMathExpression){
                changeMathP1()
            }
            
        }
    }
    
    func stopTime1(){
        timer1.invalidate()
        if(timer2.isValid == false){
            answer11.setTitle(nil, for: .normal)
            answer21.setTitle(nil, for: .normal)
            answer12.setTitle("Start", for: .normal)
            answer22.setTitle(nil, for: .normal)
            answer13.setTitle(nil, for: .normal)
            answer23.setTitle(nil, for: .normal)
        }
    }
    
    func changeMathP1(){
        // mathExpression store math expression and result
        mathP1.text = mathExpression[mathExpressionIndexP1]
        mathExpressionIndexP1 = mathExpressionIndexP1 + 1
        mathResult1 = mathExpression[mathExpressionIndexP1]
        mathExpressionIndexP1 = mathExpressionIndexP1 + 1
        
        var mathResult1Int = Int(mathResult1)! - 1
        var mathAnswerArray = [String]()
        mathAnswerArray.append(mathResult1)
        mathAnswerArray.append(String(mathResult1Int))
        mathResult1Int = mathResult1Int + 2
        mathAnswerArray.append(String(mathResult1Int))
        mathAnswerArray.shuffle()
        answer11.setTitle(mathAnswerArray[0], for: .normal)
        answer12.setTitle(mathAnswerArray[1], for: .normal)
        answer13.setTitle(mathAnswerArray[2], for: .normal)
        // change math expression, change the answer and reset timer
        counter1 = 0
        startTime1()
    }
    
    func pressAnswerAction1(answer:String){
        // if after press Start game
        if(answer != ""){
            var totalScore1 = Int(scoreP1.text!)
            // if choose right answer and index does not exceed boundary
            if(answer == mathResult1 && mathExpressionIndexP1 <= limitNumberOfMathExpression){
                totalScore1 = totalScore1! + scoreOfOneMath
                let timeScore = limitTimeOfOneMath - counter1
                if(timeScore > 0){
                    totalScore1 = totalScore1! + timeScore
                    scoreP1.text = String(totalScore1!)
                }
            }
            // check index is less than boundary
            if(mathExpressionIndexP1 < limitNumberOfMathExpression){
                changeMathP1()
            }
            else{
                stopTime1()
                mathExpressionIndexP1 = mathExpressionIndexP1 + 2
                // increase index to lock touch action after the last math
            }
            
        }
    }
    
    @IBAction func pressAnswer11(_ sender: UIButton) {
        let answer = answer11.titleLabel?.text
        pressAnswerAction1(answer: answer ?? "")
        
    }
    
    @IBAction func pressAnswer12(_ sender: UIButton) {
        let answer = answer12.titleLabel?.text
        if(answer != "Start"){
            var totalScore1 = Int(scoreP1.text!)
            if(answer == mathResult1 && mathExpressionIndexP1 <= limitNumberOfMathExpression){
                totalScore1 = totalScore1! + scoreOfOneMath
                let timeScore = limitTimeOfOneMath - counter1
                if(timeScore > 0){
                    totalScore1 = totalScore1! + timeScore
                    scoreP1.text = String(totalScore1!)
                }
            }
            if(mathExpressionIndexP1 < limitNumberOfMathExpression){
                changeMathP1()
            }
            else{
                stopTime1()
                mathExpressionIndexP1 = mathExpressionIndexP1 + 2
            }
            
        }
    }
    
    @IBAction func pressAnswer13(_ sender: UIButton) {
        let answer = answer13.titleLabel?.text
        pressAnswerAction1(answer: answer ?? "")
    }
    // finish all function of player 1 (guest)
    
    
    func startTime2() {
        timer2.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        let interval:TimeInterval = 1
        timer2 = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(timerAction2), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction2() {
        counter2 += 1
        timeP2.text = "\(counter2)"
        // auto change the math expression if over time
        if(counter2 > limitTimeOfOneMath){
            if(mathExpressionIndexP2 < limitNumberOfMathExpression){
                changeMathP2()
            }
            else{
                // stop timer when done all math
                stopTime2()
            }
            
        }
    }
    
    func stopTime2(){
        timer2.invalidate()
        if(timer1.isValid == false){
            answer11.setTitle(nil, for: .normal)
            answer21.setTitle(nil, for: .normal)
            answer12.setTitle("Start", for: .normal)
            answer22.setTitle(nil, for: .normal)
            answer13.setTitle(nil, for: .normal)
            answer23.setTitle(nil, for: .normal)
        }
    }
    
    func changeMathP2(){
        mathP2.text = mathExpression[mathExpressionIndexP2]
        mathExpressionIndexP2 = mathExpressionIndexP2 + 1
        mathResult2 = mathExpression[mathExpressionIndexP2]
        mathExpressionIndexP2 = mathExpressionIndexP2 + 1
        
        var mathResult2Int = Int(mathResult2)! - 1
        var mathAnswerArray = [String]()
        mathAnswerArray.append(mathResult2)
        mathAnswerArray.append(String(mathResult2Int))
        mathResult2Int = mathResult2Int + 2
        mathAnswerArray.append(String(mathResult2Int))
        mathAnswerArray.shuffle()
        // shuffle the position of answer
        answer21.setTitle(mathAnswerArray[0], for: .normal)
        answer22.setTitle(mathAnswerArray[1], for: .normal)
        answer23.setTitle(mathAnswerArray[2], for: .normal)
        counter2 = 0
        startTime2()
    }
    
    func pressAnswerAction2(answer:String){
        if(answer != ""){
            var totalScore2 = Int(scoreP2.text!)
            if(answer == mathResult2 && mathExpressionIndexP2 <= limitNumberOfMathExpression){
                totalScore2 = totalScore2! + scoreOfOneMath
                let timeScore = limitTimeOfOneMath - counter2
                if(timeScore > 0){
                    totalScore2 = totalScore2! + timeScore
                    scoreP2.text = String(totalScore2!)
                }
            }
            if(mathExpressionIndexP2 < limitNumberOfMathExpression){
                changeMathP2()
            }
            else{
                stopTime2()
                mathExpressionIndexP2 = mathExpressionIndexP2 + 2
            }
            
        }
    }
    
    @IBAction func pressAnswer21(_ sender: UIButton) {
        let answer = answer21.titleLabel?.text
        pressAnswerAction2(answer: answer ?? "")
    }
    
    @IBAction func pressAnswer22(_ sender: UIButton) {
        let answer = answer22.titleLabel?.text
        pressAnswerAction2(answer: answer ?? "")
    }
    
    @IBAction func pressAnswer23(_ sender: UIButton) {
        let answer = answer23.titleLabel?.text
        pressAnswerAction2(answer: answer ?? "")
    }
    
}

