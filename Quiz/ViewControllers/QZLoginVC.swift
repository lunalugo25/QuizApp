//
//  QZLoginVC.swift
//  Quiz
//
//  Created by jorge luna on 14/03/17.
//  Copyright © 2017 Jorge Luna. All rights reserved.
//

import UIKit

class QZLoginVC: UIViewController {

    @IBOutlet var nameText: UITextField!
    @IBOutlet var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapTryLogin(_ sender: Any) {
        tryLogin(user: "pruebamovil@softco.mx", password: "1oaF-g7zj")
        /*
        guard let user = nameText.text, let pass = passwordText.text else {
            showAlert(title: "Aviso", message: "Falta que ingreses tus datos, verificalos antes de continuar.")
            return
        }
        
        tryLogin(user: user, password: pass)
        */
    }
    
    func tryLogin(user:String, password:String) {
        let alertLoading = UIAlertController(title: "Validando...", message: "Espere un momento", preferredStyle: .alert)
        self.present(alertLoading, animated: true) {
            QZLoginWS.validate(user: user, password: password) { (isCorrect, message, information) in
                alertLoading.dismiss(animated: false, completion: nil)
                if isCorrect {
                    let user = QZUser(dictionary: information)
                    QZUser.shared.name = user.name
                    QZUser.shared.cookie = user.cookie
                    QZUser.shared.quiz = user.quiz
                    self.presentQuiz()
                } else {
                    self.showAlert(title: "Aviso", message: message)
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let accept = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(accept)
        present(alert, animated: true, completion: nil)
    }
    
    func presentQuiz() {
        let story = UIStoryboard(name: "QZMain", bundle: nil)
        guard let welcome = story.instantiateViewController(withIdentifier: "QZWelcomeVC") as? QZWelcomeVC else {
            return
        }
        
        present(welcome, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
