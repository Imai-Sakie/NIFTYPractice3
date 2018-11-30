//
//  LoginViewController.swift
//  NIFTYPractice3
//
//  Created by 今井咲江 on 2018/11/30.
//  Copyright © 2018 imai sakie. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapSignUpButton(_ sender: UIButton) {
        let user = User(name: nameTextField.text!, password: passwordTextField.text!)
        user.signUp { (message) in
            if let unwrappedMessage = message {
                self.showAlert(message: unwrappedMessage)
                print("サインアップ失敗")
            } else {
                self.dismiss(animated: true, completion: nil)
                print("サインアップ成功")
            }
        }
    }
    
    func showAlert(message: String?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        let user = User(name: nameTextField.text!, password: passwordTextField.text!)
        user.login { (message) in
            if let unwrappedMessage = message {
                self.showAlert(message: unwrappedMessage)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
