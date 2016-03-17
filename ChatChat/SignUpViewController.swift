//
//  SignUpViewController.swift
//  We Care
//
//  Created by Abhigyan Singh on 01/03/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet var fNameTF: UITextField!
    @IBOutlet var lNameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passTF: UITextField!
    @IBOutlet var mobileTF: UITextField!
    @IBOutlet var genderTF: UITextField!
    @IBOutlet var dobTF: UITextField!
    @IBOutlet var categorySelect: UISegmentedControl!
    @IBAction func nextBTN(sender: AnyObject) {
        
        Config.fname = fNameTF.text!
        Config.lname = lNameTF.text!
        Config.email = emailTF.text!
        Config.password = passTF.text!
        Config.mobile = mobileTF.text!
        Config.gender = genderTF.text!
        Config.dob = dobTF.text!
        
        switch(categorySelect.selectedSegmentIndex){
            
        case 0 : let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 let vc = storyboard.instantiateViewControllerWithIdentifier("PatientInfoViewController") as UIViewController
                 self.presentViewController(vc, animated: true, completion: nil)
                 break
        case 1 : let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 let vc = storyboard.instantiateViewControllerWithIdentifier("DoctorInfoViewController") as UIViewController
                 self.presentViewController(vc, animated: true, completion: nil)
                 break
        case 2 : let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 let vc = storyboard.instantiateViewControllerWithIdentifier("PharmaInfoViewController") as UIViewController
                 self.presentViewController(vc, animated: true, completion: nil)
                 break
        default : print("Error")
                  break
            
        }
  
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
