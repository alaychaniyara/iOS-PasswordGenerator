//
//  ViewController.swift
//  iOS-InClass04
//
//  Created by Alay Chaniyara on 11/9/18.
//  Copyright © 2018 Alay Chaniyara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var displayData = ["Weak (Length 5)","Medium (Length 8)","Strong (Length 15)","Extra Strong (Length 25)"]
    let size1 = 5
    let size2 = 8
    let size3 = 15
    let size4 = 25
    
    var selectedValue = ""
    var chosenPasswordLength = ""
    
    var generatedPassword = ""
    
    var allPasswords = [String]()
    
    @IBOutlet weak var lblSelectedPassword: UILabel!
    
    
    @IBOutlet var numberOfPasswords: UITextField!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPasswords"{
            let dest = segue.destination as! PasswordViewController
            dest.displayPasswords = allPasswords
        }
    }
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PWDStrength", for: indexPath)
        let item = cell.viewWithTag(7) as! UILabel
        item.text = displayData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("123")
        let passwordLength = displayData[indexPath.row]
        print(passwordLength)
        chosenPasswordLength = passwordLength
        selectedValue = numberOfPasswords.text!
    }
    @IBAction func generate(_ sender: Any) {
        allPasswords.removeAll()
        if numberOfPasswords.text == ""
        {
            let alertController = UIAlertController(title: "Error", message: "Input cannot be Empty", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default Action"), style: .default, handler: nil))
            self.present(alertController, animated: true)
            lblSelectedPassword.text = "Enter number of passwords"
        }else if chosenPasswordLength == ""
        {
            let alertController = UIAlertController(title: "Error", message: "Input cannot be Empty", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default Action"), style: .default, handler: nil))
            self.present(alertController, animated: true)
            lblSelectedPassword.text = "Choose a valid password length"
        }else{
            var length = 0
            if chosenPasswordLength.elementsEqual("Weak (Length 5)"){
                length = 5
            }else if chosenPasswordLength.elementsEqual("Medium (Length 8)"){
                length = 8
            }else if chosenPasswordLength.elementsEqual("Strong (Length 15)"){
                length = 15
            }else if chosenPasswordLength.elementsEqual("Extra Strong (Length 25)"){
                length = 25
            }
            let value = Int(numberOfPasswords.text!)
            //print(value)
            DispatchQueue.global(qos: .background).async {
                for _ in 1...value! {
                    self.generatedPassword = AppsData.getPassword(len: length)
                    self.allPasswords.append(self.generatedPassword)
                    
                }
                print(self.allPasswords.count)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showPasswords", sender: self)
                }
            }
            }
        }
    
}

