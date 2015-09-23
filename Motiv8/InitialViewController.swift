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
		
		let loginButton = FBSDKLoginButton()
		loginButton.readPermissions = ["public_profile", "email", "user_friends"]
		loginButton.center = self.view.center
		loginButton.delegate = self
		//println("Current user id \(FBSDKAccessToken.currentAccessToken().userID)")
		self.view.addSubview(loginButton)
		
		/*let urlString = "http://52.88.154.31/motiv8/users";
		let request = NSMutableURLRequest(URL: NSURL(string: urlString)!);
		_ = NSURLSession.sharedSession()
		request.HTTPMethod = "POST"
		let err: NSError?
		let password = "Motiv8Password"
		//let reqText = ["firstName": "Kaveh", "lastName": "Karimiyanha", "accessToken": "\(FBSDKAccessToken.currentAccessToken().tokenString)", "fbId": "\(FBSDKAccessToken.currentAccessToken().userID)"]
		let reqText = ["firstName": "Kaveh", "lastName": "Karimiyanha", "accessToken": "Access Token", "fbId": "FaceBookID"]
		
		do {
			//print("reqText...\n\(reqText)")
		
			//This Line fills the web service with required parameters.
			request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(reqText, options: [])
		} catch let error as NSError {
			err = error
			request.HTTPBody = nil
		}
		
		request.setValue(password, forHTTPHeaderField: "User-Agent")
		//request.setValue(FBSDKAccessToken.currentAccessToken().userID, forHTTPHeaderField: "From")
		request.setValue("Kaveh", forHTTPHeaderField: "From")

		
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		
		var response: NSURLResponse?
		
		let data =  (try! NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)) as NSData

		if let json = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)) as? NSDictionary {
			print("json after put request...\njson.count: \(json.count)\n\(json)")
			if let first_name = json["firstName"] as? String {
				if first_name != "Kaveh" {
					print("first name doesn't match")
				}
				if let last_name = json["lastName"] as? String {
					if last_name != "Karimiyanha" {
						print("last name doesn't match")
					}
					if let accessToken = json["accessToken"] as? String {
						//defaults.setObject(ageInt, forKey: "PixieUserAge")
						if accessToken != FBSDKAccessToken.currentAccessToken().tokenString {
							print("accessToken doesn't match")
						}
						if let fbId = json ["fbId"] as? String {
							if fbId != FBSDKAccessToken.currentAccessToken().userID {
								print("fbId doesn't match")
							}
							
						} else {
							print("error fbId")
						}
					} else {
						print("error accessToken")
					}
				} else {
					print("error last_name")
				}
			} else {
				print("error first_name")
			}
		} else {
			print("error json")
		}*/
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