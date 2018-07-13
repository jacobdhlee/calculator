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

    @IBAction func buttonPress(_ sender: AnyObject) {
        // tag 11 = reset
        if sender.tag == 11 {
            viewOnLabel = 0
            math = ""
            priority = ""
            previous = ""
            savedOp = [Int]()
            results.text = String(format: "%.0f", viewOnLabel)
        }
        // tag 0 - 10 = numbers
        else if sender.tag >= 0 && sender.tag < 10 {
            math += String(sender.tag)
            results.text = math
        }
        //tag 14 devide 15 times 16 minus 17 plus
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
                previous = math
                savedOp.append(sender.tag)
                math = ""
            }
        }
        //tag 18 calculate
        else if sender.tag == 18 {
            print(savedOp)
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

