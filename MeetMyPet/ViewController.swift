//
//  ViewController.swift
//  MeetMyPet
//
//  Created by Darko Spasovski on 7/15/16.
//  Copyright © 2016 Irina Smokvarska. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

   
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }
    
    @IBAction func fbBtnPressed(sender: UIButton!) {
        let facebookLogin = FBSDKLoginManager()
        
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logen in with facebook. \(accessToken)")
                
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                
                FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                    
                    if error != nil {
                        print("Login failed. \(error)")
                    } else {
                        print("Logged In! \(user)")
                        let userdict = ["provider": "facebook"]
                        DataService.ds.saveFacebookUser(user!.uid, user: userdict)
                        NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                }
                
            }

        }
        
    }
    @IBAction func attemptSignUp(sender: AnyObject) {
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            FIRAuth.auth()?.createUserWithEmail(email, password: pwd) { (user, error) in
                
                if error != nil {
                    
                    print("Sign up failed. \(error?.localizedDescription)")
                    self.showErrorAlert("Error", msg: (error?.localizedDescription)!)
                } else {
                    print("Signed Up! \(user)")
                    DataService.ds.saveUser(email, password: pwd)
                    NSUserDefaults.standardUserDefaults().setValue(user?.uid, forKey: KEY_UID)
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
                
            }
            
            
        } else {
            showErrorAlert("Email and Password Required", msg: "You must enter an email and a password")
        }

    }
    
    @IBAction func attemptLogin(sender: UIButton!) {
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            FIRAuth.auth()?.signInWithEmail(email, password: pwd) { (user, error) in
                
                if error != nil {
                    print("Login failed. \(error?.localizedDescription)")
                    self.showErrorAlert("Error", msg: (error?.localizedDescription)!)
                } else {
                    print("Logged Up! \(user)")
                    NSUserDefaults.standardUserDefaults().setValue(user?.uid, forKey: KEY_UID)
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
                
            }
            
            
        } else {
            showErrorAlert("Email and Password Required", msg: "You must enter an email and a password")
        }

        
        
  }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    }





