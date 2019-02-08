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
        self.mathP1.transform = self.mathP1.transform.rotated(by: CGFloat(Double.pi))
        self.scoreLabelP1.transform = self.scoreLabelP1.transform.rotated(by: CGFloat(Double.pi))
        self.answer11.transform = self.answer11.transform.rotated(by: CGFloat(Double.pi))
        self.answer12.transform = self.answer12.transform.rotated(by: CGFloat(Double.pi))
        self.answer13.transform = self.answer13.transform.rotated(by: CGFloat(Double.pi))
        
    }
    
    @IBAction func pressPlayGame(_ sender: UIButton) {
        if(answer12.titleLabel?.text == "Start"){
            let numberOfMathExpression:Int = limitNumberOfMathExpression / 2
            mathExpression = math.createExpression(numberOfMath: numberOfMathExpression)
            mathP1.text = mathExpression[mathExpressionIndexP1]
            mathExpressionIndexP1 = mathExpressionIndexP1 + 1
            mathP2.text = mathExpression[mathExpressionIndexP2]
            mathExpressionIndexP2 = mathExpressionIndexP2 + 1
            mathResult1 = mathExpression[mathExpressionIndexP1]
            mathResult2 = mathResult1
            mathExpressionIndexP1 = mathExpressionIndexP1 + 1
            mathExpressionIndexP2 = mathExpressionIndexP2 + 1
            var mathResult1Int = Int(mathResult1)! - 1
            answer11.setTitle(mathResult1, for: .normal)
            answer21.setTitle(mathResult1, for: .normal)
            answer12.setTitle(String(mathResult1Int), for: .normal)
            answer22.setTitle(String(mathResult1Int), for: .normal)
            mathResult1Int = Int(mathResult1)! + 1
            answer13.setTitle(String(mathResult1Int), for: .normal)
            answer23.setTitle(String(mathResult1Int), for: .normal)
            
            // the first question have same result for both players
            startTime1()
            startTime2()
            
            for i in mathExpression {
                print(i)
            }
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
    }
    
    func changeMathP1(){
        mathP1.text = mathExpression[mathExpressionIndexP1]
        mathExpressionIndexP1 = mathExpressionIndexP1 + 1
        mathResult1 = mathExpression[mathExpressionIndexP1]
        mathExpressionIndexP1 = mathExpressionIndexP1 + 1
        answer11.setTitle(mathResult1, for: .normal)
        let mathResult1Int = Int(mathResult1)! - 1
        answer12.setTitle(String(mathResult1Int), for: .normal)
        answer13.setTitle(String(mathResult1Int + 2), for: .normal)
        counter1 = 0
        startTime1()
    }
    
    func pressAnswerAction1(answer:String){
        if(answer != ""){
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
        if(counter2 > limitTimeOfOneMath){
            if(mathExpressionIndexP2 < limitNumberOfMathExpression){
                changeMathP2()
            }
            else{
                stopTime2()
            }
            
        }
    }
    
    func stopTime2(){
        timer2.invalidate()
    }
    
    func changeMathP2(){
        mathP2.text = mathExpression[mathExpressionIndexP2]
        mathExpressionIndexP2 = mathExpressionIndexP2 + 1
        mathResult2 = mathExpression[mathExpressionIndexP2]
        mathExpressionIndexP2 = mathExpressionIndexP2 + 1
        answer21.setTitle(mathResult2, for: .normal)
        let mathResult2Int = Int(mathResult2)! - 1
        answer22.setTitle(String(mathResult2Int), for: .normal)
        answer23.setTitle(String(mathResult2Int + 2), for: .normal)
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

