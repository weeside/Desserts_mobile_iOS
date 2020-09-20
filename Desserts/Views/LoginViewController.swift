//
//  LoginViewController.swift
//  Desserts
//
//  Created by 김예랑 on 2020/09/13.
//  Copyright © 2020 김예랑. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginPageCommentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributedString = NSMutableAttributedString(string: "당신의 오늘 하루가\n궁금해요 🙂", attributes: [
          .font: UIFont(name: "SpoqaHanSans-Bold", size: 33.0)!,
          .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 1.0, green: 152.0 / 255.0, blue: 152.0 / 255.0, alpha: 1.0), range: NSRange(location: 4, length: 5))
        loginPageCommentLabel.attributedText = attributedString
    }

    @IBAction func naverLoginButton(_ sender: UIButton) {
        performSegue(withIdentifier: "naverLoginToQuestion", sender: self)
    }
    
    @IBAction func facebookLoginButton(_ sender: UIButton) {
        performSegue(withIdentifier: "facebookLoginToQuestion", sender: self)
    }
    
    
    
}
