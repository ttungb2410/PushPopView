//
//  ViewMath.swift
//  PushPopView
//
//  Created by TTung on 2/13/17.
//  Copyright © 2017 TTung. All rights reserved.
//

import UIKit

class ViewMath: UIViewController {

   
    
    
    @IBOutlet weak var btn_startStop: UIButton!
    
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var tf_right: UITextField!
    @IBOutlet weak var tf_wrong: UITextField!
    
    @IBOutlet weak var lbl_numb1: UILabel!
    @IBOutlet weak var lbl_sign: UILabel!
    @IBOutlet weak var lbl_numb2: UILabel!
    
    @IBOutlet weak var lbl_numb1Edit: UILabel!
    @IBOutlet weak var lbl_signEdit: UILabel!
    @IBOutlet weak var lbl_numb2Edit: UILabel!
    @IBOutlet weak var lbl_result: UILabel!
    
    @IBOutlet weak var btn_answer1: UIButton!
    @IBOutlet weak var btn_answer2: UIButton!
    @IBOutlet weak var btn_answer3: UIButton!
    
    
    var countRight = 0
    var countWrong = 0
    var gameTime: Timer!
    var time = 0
    var running = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func action_play(_ sender: Any) {                             // thuc hien chay chuong trinh, khi Stop dung chay lai Reset chuong trinh
        startStop()
        
    }
   
    
    @IBAction func action_defferntAccount(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)        // tro ve view Login
    
    }

    @IBAction func action_answer(_ sender: UIButton) {                      // thuc hien check dap an va chay chuong trinh
        check(sender)
        setRandom()
        start()
    }
    
    func start(){                                                           // thoi gian thuc hien 1 phep tinh
         time = 5
    }
    
    func countDown(){                                                       // dem nguoc
        time = time - 1                                                     // neu het thoi gian khong chon se + 1 vao Wrong
        lbl_time.textColor = UIColor.blue
        if time <= 3 && time > 0{
            lbl_time.textColor = UIColor.red
        }
        if time == 0 {
            lbl_time.textColor = UIColor.black
            start()
            checkSignWrong()
            setRandom()
        }
        lbl_time.text  = String(time)
        
    }
    func resetTime(){
        gameTime.invalidate()
    }
    
    func startStop(){                                                           // ham Start va Stop chuong trinh
        if running == 1 {
            btn_startStop.setTitle(String("Stop"), for: UIControlState())
            start()
            countRight = 0
            tf_right.text = "0"
            countWrong = 0
            tf_wrong.text = "0"
            gameTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil , repeats: true)
            setRandom()
            running = 2
            
        }else{
            btn_startStop.setTitle("Start", for: UIControlState())
        
            resetTime()
            running = 1
        }
    }
    
    
    func setRandom(){                                                           // set Random 2 so va dau
        var numb1 = Int(arc4random_uniform(9))+1
        var numb2 = Int(arc4random_uniform(9))+1
        
       
            lbl_numb1.text = String(numb1)
            lbl_numb2.text = String(numb2)
            
        let randomSign = Int(arc4random_uniform(4))
        if randomSign == 0 {
            lbl_sign.text = "+"
        }
        else if randomSign == 1{
            lbl_sign.text = "-"
        }
        else if  randomSign == 2{
            lbl_sign.text = "*"
            }
        else{                                                                       // trong phep chia chi thuc hien phep chia het
            lbl_sign.text = "/"
            let du = numb1 % numb2
            while ( du != 0) {
                 numb1 = Int(arc4random_uniform(9))+1
                 numb2 = Int(arc4random_uniform(9))+1
                lbl_numb1.text = String(numb1)
                lbl_numb2.text = String(numb2)
            }
           
            }
        setResult()
    }
    
    
    func setResult(){                                                                 // Ham thu tu cac dap an de chon
        var randomA = Int(arc4random_uniform(9))+1
        var randomB = Int(arc4random_uniform(9))+1
        let result = getResult()

        while (randomA == randomB || randomA == result || randomB == result) {
             randomA = Int(arc4random_uniform(9))+1
             randomB = Int(arc4random_uniform(9))+1
        }
        
        let randomPos = Int(arc4random_uniform(2))+1
        
        if randomPos == 1  {
            
            btn_answer1.setTitle(String(result), for: UIControlState())
            btn_answer2.setTitle(String(randomA), for: UIControlState())
            btn_answer3.setTitle(String(randomB), for: UIControlState())
        
              }
        else if randomPos == 2  {

            btn_answer1.setTitle(String(randomA), for: UIControlState())
            btn_answer2.setTitle(String(result), for: UIControlState())
            btn_answer3.setTitle(String(randomB), for: UIControlState())
    
        }else {

            btn_answer1.setTitle(String(randomA), for: UIControlState())
            btn_answer2.setTitle(String(randomB), for: UIControlState())
            btn_answer3.setTitle(String(result), for: UIControlState())
        }
    }
    func getResult() -> Int{                                                                // thuc hien phep tinh voi cac so va dau tuong ung
        
        var result = 0
        if lbl_sign.text == "+" {
            result = sum(p1: Int(lbl_numb1.text!)!, p2: Int(lbl_numb2.text!)!)
        }
         if lbl_sign.text == "-"{
            result = subtr(p1: Int(lbl_numb1.text!)!, p2: Int(lbl_numb2.text!)!)
    }
        if lbl_sign.text == "*"{
            result = mult(p1: Int(lbl_numb1.text!)!, p2: Int(lbl_numb2.text!)!)
        }
        if lbl_sign.text == "/"{
            result = div(p1: Int(lbl_numb1.text!)!, p2: Int(lbl_numb2.text!)!)
        }
        return result
    }
    
    func sum(p1: Int, p2: Int) -> Int{
        return p1+p2
    }
    
    func subtr(p1: Int, p2: Int) -> Int{
        return p1-p2
    }
    
    func mult(p1: Int, p2: Int) -> Int{
        return p1*p2
    }
    
    func div(p1: Int, p2: Int) -> Int{
        return p1/p2
    }
    
    func check(_ sender:UIButton){                                                          // Ham Check Dung Sai
        tf_right.text = String(countRight)                                                  // Neu Sai se tra ve phep tinh dung o phia duoi
        tf_wrong.text = String(countWrong)
        
            let resultSum = Int(lbl_numb1.text!)! + Int(lbl_numb2.text!)!
            let resultSubtr = Int(lbl_numb1.text!)! - Int(lbl_numb2.text!)!
            let resultMult =  Int(lbl_numb1.text!)! * Int(lbl_numb2.text!)!
            let resultDiv = Int(lbl_numb1.text!)! / Int(lbl_numb2.text!)!
        if resultSum == Int(sender.currentTitle!)! || resultSubtr == Int(sender.currentTitle!)! || resultMult == Int(sender.currentTitle!)! || resultDiv == Int(sender.currentTitle!) {
            countRight = countRight + 1
            tf_right.text = String(countRight)
        }
        else if resultSum != Int(sender.currentTitle!)! || resultSubtr != Int(sender.currentTitle!)! || resultMult != Int(sender.currentTitle!)! || resultDiv != Int(sender.currentTitle!){
           
            checkSignWrong()
        }
    }
    
    func checkSignWrong(){                                                                     // Check Sai theo Dau
        
        let resultSum = Int(lbl_numb1.text!)! + Int(lbl_numb2.text!)!
        let resultSubtr = Int(lbl_numb1.text!)! - Int(lbl_numb2.text!)!
        let resultMult =  Int(lbl_numb1.text!)! * Int(lbl_numb2.text!)!
        let resultDiv = Int(lbl_numb1.text!)! / Int(lbl_numb2.text!)!
        countWrong = countWrong + 1
        tf_wrong.text = String(countWrong)
        
        if lbl_sign.text == "+" {
            
            lbl_result.text = String(resultSum)
            lbl_numb1Edit.text = lbl_numb1.text
            lbl_signEdit.text = lbl_sign.text
            lbl_numb2Edit.text = lbl_numb2.text
        }
        else if lbl_sign.text == "-" {
            
            lbl_result.text = String(resultSubtr)
            lbl_numb1Edit.text = lbl_numb1.text
            lbl_signEdit.text = lbl_sign.text
            lbl_numb2Edit.text = lbl_numb2.text
        }
        else if lbl_sign.text == "*" {
            lbl_result.text = String(resultMult)
            lbl_numb1Edit.text = lbl_numb1.text
            lbl_signEdit.text = lbl_sign.text
            lbl_numb2Edit.text = lbl_numb2.text
        }
        else if lbl_sign.text == "/" {
            lbl_result.text = String(resultDiv)
            lbl_numb1Edit.text = lbl_numb1.text
            lbl_signEdit.text = lbl_sign.text
            lbl_numb2Edit.text = lbl_numb2.text
        }
    }
  
    
}
