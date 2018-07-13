//
//  ViewController.swift
//  Calculator
//
//  Created by Donghee Lee on 7/11/18.
//  Copyright © 2018 jacob_lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewOnLabel : Double = 0
    var math = ""
    var priority : String = ""
    var previous = ""
    var savedOp = [Int]()
    
    @IBOutlet weak var results: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        results.text = String(format: "%.0f", viewOnLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setZero(setting: String) {
        viewOnLabel = 0
        math = setting
        priority = ""
        previous = ""
        savedOp = [Int]()
    }
    
    @IBAction func buttonPress(_ sender: AnyObject) {
        if sender.tag == 11 {
            setZero(setting: "")
            results.text = String(format: "%.0f", viewOnLabel)
        }
        else if sender.tag >= 0 && sender.tag < 10 {
            math += String(sender.tag)
            results.text = math
        }
        else if sender.tag == 14 || sender.tag == 15 {
            if priority != "" {
                let op = sender.tag
                priority = calculate(priority: priority, math: math, op: op!)
                math = ""
            } else {
                priority = math
                savedOp.append(sender.tag)
                math = ""
            }
        }
            
        else if sender.tag == 16 || sender.tag == 17 {
            if previous != "" {
                let op = sender.tag
                previous = calculate(priority: previous, math: math, op: op!)
                math = ""
            } else {
                if savedOp.count == 0 {
                    previous = math
                    savedOp.append(sender.tag)
                    math = ""
                }
                if savedOp[0] == 14 || savedOp[0] == 15 {
                    previous = calculate(priority: priority, math: math, op: savedOp[0])
                    savedOp.removeFirst(1)
                    savedOp.append(sender.tag)
                    math = ""
                    priority = ""
                }
            }
        }
        else if sender.tag == 18 {
            if savedOp.count > 1 {
                let first = calculate(priority: priority, math: math, op: savedOp[1])
                let second = calculate(priority: first, math: previous, op: savedOp[0])
                results.text = second
                setZero(setting: second)
            } else {
                if priority != "" {
                    let result = calculate(priority: priority, math: math, op: savedOp[0])
                    results.text = result
                    setZero(setting: result)
                }
                else if previous != "" {
                    let result = calculate(priority: previous, math: math, op: savedOp[0])
                    results.text = result
                    setZero(setting: result)
                }
            }
        }
        
    }
    
    func calculate(priority : String, math : String , op : Int) -> String {
        var calculated = ""
        if op == 14 {
            calculated = String(Double(priority)! / Double(math)!)
        }
        else if op == 15 {
            calculated =  String(Double(priority)! * Double(math)!)
        }
        else if op == 16 {
            calculated = String(Double(priority)! - Double(math)!)
        }
        else if op == 17 {
            calculated = String(Double(priority)! + Double(math)!)
        }
        return calculated
    }
    
}

