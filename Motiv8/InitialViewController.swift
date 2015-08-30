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
			println("Not logged in...")
		}
		else
		{
			println("Logged in...")
		}
		
		var loginButton = FBSDKLoginButton()
		loginButton.readPermissions = ["public_profile", "email", "user_friends"]
		loginButton.center = self.view.center
		loginButton.delegate = self
		self.view.addSubview(loginButton)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
	{
		if error == nil
		{
			println("Login complete.")
			self.performSegueWithIdentifier("presentHome", sender: self)
		}
		else
		{
			println(error.localizedDescription)
		}
		
	}
	
	func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
	{
		println("User logged out...")
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "presentHome" {
			if let homeVC = segue.destinationViewController as? HomeViewController {
				self.modalPresentationStyle = UIModalPresentationStyle.Custom
			}
		}
	}
	
}