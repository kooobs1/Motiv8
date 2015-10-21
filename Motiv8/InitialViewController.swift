//
//  InitialViewController.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 7/30/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class InitialViewController: UIViewController, FBSDKLoginButtonDelegate {
	@IBOutlet weak var bckImage: UIImageView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		if (FBSDKAccessToken.currentAccessToken() == nil)
		{
			print("Not logged in...")
		}
		else
		{
			print("Logged in...")
			self.performSegueWithIdentifier("presentHome", sender: self)
		}
		
		self.view.addSubview(bckImage)
		
		let loginButton = FBSDKLoginButton()
		loginButton.readPermissions = ["public_profile", "email", "user_friends"]
		loginButton.center = self.view.center
		loginButton.delegate = self
		//println("Current user id \(FBSDKAccessToken.currentAccessToken().userID)")
		self.view.addSubview(loginButton)
		self.view.bringSubviewToFront(loginButton)
		self.view.sendSubviewToBack(bckImage)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
	{
		if error == nil
		{
			//NSLog("%@", result.objectForKey("email"))
			print("Login complete.")
            
            let urlString = "http://52.88.154.31/motiv8/user";
            let url = NSURL(string: urlString)
            let request = NSMutableURLRequest(URL: url!)
            var response: NSURLResponse?
            var err: NSError
            request.HTTPMethod = "POST"
            
            let password = "Motiv8Password"
            let reqText = ["firstName": "Kaveh", "lastName": "Karimiyanha", "accessToken": "\(FBSDKAccessToken.currentAccessToken().tokenString)", "fbId": "\(FBSDKAccessToken.currentAccessToken().userID)"]
            //let reqText = ["firstName": "Kaveh", "lastName": "Karimiyanha", "accessToken": "Access Token", "fbId": "FaceBookID"]
            
            do {
                
                //This Line fills the web service with required parameters.
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(reqText, options: [])
            } catch let error as NSError {
                err = error
                request.HTTPBody = nil
            }
            
            request.setValue(password, forHTTPHeaderField: "User-Agent")
            request.setValue(FBSDKAccessToken.currentAccessToken().userID, forHTTPHeaderField: "From")
            //request.setValue("Kaveh", forHTTPHeaderField: "From")
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let data =  (try! NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)) as NSData
            
            let resp = NSString(data: data, encoding: NSUTF8StringEncoding)
            print(resp)
            
			self.performSegueWithIdentifier("presentHome", sender: self)
		}
		else
		{
			print(error.localizedDescription)
		}
		
	}
	
	func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
	{
		print("User logged out...")
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "presentHome" {
			if let _ = segue.destinationViewController as? HomeViewController {
				self.modalPresentationStyle = UIModalPresentationStyle.Custom
			}
		}
	}
	
}