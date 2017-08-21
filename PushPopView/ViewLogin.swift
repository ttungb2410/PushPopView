//
//  ViewLogin.swift
//  PushPopView
//
//  Created by TTung on 2/13/17.
//  Copyright © 2017 TTung. All rights reserved.
//

import UIKit

class ViewLogin: UIViewController {

    
    @IBOutlet weak var tf_usernameLogin: UITextField!
    @IBOutlet weak var tf_passwordLogin: UITextField!
    @IBOutlet weak var lbl_login: UILabel!
    
    @IBOutlet weak var tf_usernameRegister: UITextField!
    @IBOutlet weak var tf_passwordRegister: UITextField!
    @IBOutlet weak var lbl_register: UILabel!
    @IBOutlet weak var btn_register: UIButton!
    
    @IBOutlet weak var lbl_accountList: UILabel!
    @IBOutlet weak var btn_accountList: UIButton!
    
    @IBOutlet weak var tf_userAccountDel: UITextField!
    @IBOutlet weak var lbl_accountDelete: UILabel!
    @IBOutlet weak var btn_deleteAccount: UIButton!
    @IBOutlet weak var tf_passAccountDel: UITextField!
    
    var user = ["ttung":"123", "techmaster":"1" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

   
    
    @IBAction func action_login(_ sender: Any) {                                // check Login
        checkLogin()
    }
  
    @IBAction func action_newAccount(_ sender: Any) {                           // nut hien cai text va button de register
        tf_usernameRegister.isHidden = false
        tf_passwordRegister.isHidden = false
        btn_register.isHidden = false
        btn_accountList.isHidden = false
    }

    @IBAction func action_register(_ sender: Any) {                             // check tai khoan
        checkRegister()                                                         // tra ve thong bao
        lbl_register.isHidden = false
    }
   
    @IBAction func action_accountList(_ sender: Any) {                          // Hien thi List Account va cac chuc nang de Delete Account
        lbl_accountList.isHidden = false
        tf_userAccountDel.isHidden = false
        tf_passAccountDel.isHidden = false
        btn_deleteAccount.isHidden = false
        accountList()
        
    }
    
    @IBAction func action_deleteAccount(_ sender: Any) {                         // Xoa Account
        deleteAccount()
    }
    
  
    
    func checkLogin(){                                                            // check Login: Dung se sang view Math
        if let passwd = user[tf_usernameLogin.text!]{                             // Hien thi thong bao
            if passwd == tf_passwordLogin.text {
                lbl_login.isHidden = false
                lbl_login.text = String("Dang Nhap Thanh Cong")
                let v3 = self.storyboard?.instantiateViewController(withIdentifier: "V3") as! ViewMath
                self.navigationController?.pushViewController(v3, animated: true)
                lbl_login.isHidden = true
            }else{
                lbl_login.isHidden = false
                lbl_login.text = String("Mat Khau Khong Dung")
            }
        }else{
            lbl_login.isHidden = false
            lbl_login.text = String("Tai Khoan Khong Dung")
        }
        
    }
    
    func checkRegister(){                                                          // check tai khoan de Dang Ky
        if let passwd = user[tf_usernameRegister.text!]{                           // Hien Thi Thong Bao
            lbl_register.text = "Tai Khoan Da Ton Tai"
        }else{
            user[tf_usernameRegister.text!] = tf_passwordRegister.text!            // Them Tai Khoan
            lbl_register.text = String("Dang Ky Thanh Cong")
        }
    }
    
    func accountList(){                                                             // Hien thi List Account
        var fullList = ""
        
        for(key,value) in user{
                fullList += "\(key)\n"
            lbl_accountList.text = "\(fullList)"
        }
    }
    
    func deleteAccount(){                                                           // Kiem tra tai khoan va xoa Account
        if let passwd = user[tf_userAccountDel.text!]{
            if passwd == tf_passAccountDel.text{
            let delete = tf_userAccountDel.text
            user.removeValue(forKey: delete!)
            lbl_accountDelete.text = String("Da Xoa Thanh Cong")
            lbl_accountDelete.isHidden = false
            }else{
                lbl_accountDelete.isHidden = false
                lbl_accountDelete.text = String("Mat Khau Khong Dung")
                
            }
        }else{
            lbl_accountDelete.text = String("Khong co tai khoan nay")
            lbl_accountDelete.isHidden = false
        }
    }
    
    
    @IBAction func action_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //aaa
}
