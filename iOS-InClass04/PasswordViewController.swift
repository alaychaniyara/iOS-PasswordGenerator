//
//  PasswordViewController.swift
//  iOS-InClass04
//
//  Created by Alay Chaniyara on 11/9/18.
//  Copyright © 2018 Alay Chaniyara. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return password.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PWD_List", for: indexPath)
        let item = cell.viewWithTag(20) as! UILabel
        item.text = password[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passwordChosen = password[indexPath.row]
        print(passwordChosen)
        performSegue(withIdentifier: "backtoMain", sender: self)
    }
    var displayPasswords = [String]()
    
    var password = [String]()
    
    var sendBack:String = ""
    var passwordChosen:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Passwords"
        password = displayPasswords
        print(password)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backtoMain"{
            let dest = segue.destination as! ViewController
            dest.lblSelectedPassword.text = passwordChosen
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
