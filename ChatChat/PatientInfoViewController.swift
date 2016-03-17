//
//  PatientInfoViewController.swift
//  We Care
//
//  Created by Abhigyan Singh on 02/03/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import Firebase

class PatientInfoViewController: UIViewController {
    
    var uid = ""

    @IBOutlet var heightTF: UITextField!
    @IBOutlet var weightTF: UITextField!
    @IBOutlet var pastDescTF: UITextView!
    
    @IBAction func signUpBTN(sender: AnyObject) {
        
        let patientHeight = heightTF.text
        let patientWeight = weightTF.text
        let patientpast = pastDescTF.text
        
        Config.firebase.createUser(Config.email, password: Config.password,
            withValueCompletionBlock: { error, result in
                
                if error != nil {
                    print("Error :  \(error)")
                } else {
                    self.uid = (result["uid"] as? String)!
                    print("Successfully created user account with uid: \(self.uid)")

                    let newPatient = [
                        "email" : Config.email as String,
                        "firstName" : Config.fname as String,
                        "lastName" : Config.lname as String,
                        "mobile" : Config.mobile as String,
                        "gender" : Config.gender as String,
                        "dob" : Config.dob as String,
                        "height" : patientHeight! as String,
                        "weight" : patientWeight! as String,
                        "patientPast" : patientpast! as String
                    ];
                    
                    Config.firebase.childByAppendingPath("users/patients/\(self.uid)").setValue(newPatient, withCompletionBlock: {
                    (error:NSError?, ref:Firebase!) in
                    if (error != nil) {
                        print("Data could not be saved.")
                     } else {
                        print("Data saved successfully!")
                     }
                    })
                    
                    let userType = ["category" : "patient"]
                    Config.firebase.childByAppendingPath("userType/\(self.uid)").setValue(userType, withCompletionBlock: {
                    (error:NSError?, ref:Firebase!) in
                    if (error != nil) {
                        print("Data could not be saved.")
                    } else {
                        print("Data saved successfully!")
                    }
                    })
                    let storyboard = UIStoryboard(name: "PatientHome", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("PatientHomeViewController") as UIViewController
                    self.presentViewController(vc, animated: true, completion: nil)
       }
     })
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
