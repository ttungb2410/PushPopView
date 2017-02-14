//
//  ViewController.swift
//  PushPopView
//
//  Created by TTung on 2/13/17.
//  Copyright © 2017 TTung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var im_logo: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        im_logo.alpha = 0
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 5, animations: {self.im_logo!.alpha = 1})
    }
  
    @IBAction func action_pushLogin(_ sender: Any) {
    
        let v2 = self.storyboard?.instantiateViewController(withIdentifier: "V2") as! ViewLogin
        self.navigationController?.pushViewController(v2, animated: true)
       
    }


}

