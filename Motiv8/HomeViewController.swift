//
//  ViewController.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 7/29/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
	
	var navTransitionOperator = NavigationTransitionOperator()
	@IBOutlet weak var webViewBG: UIWebView!
	//var moviePlayer: MPMoviePlayerController?
	@IBOutlet weak var btn: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		var filePath = NSBundle.mainBundle().pathForResource("motiv8gif", ofType: "gif")
		var gif = NSData(contentsOfFile: filePath!)
		
		webViewBG.loadData(gif, MIMEType: "image/gif", textEncodingName: nil, baseURL: nil)
		webViewBG.userInteractionEnabled = false
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "presentNav" {
			let toViewController = segue.destinationViewController as! NavigationViewController
			self.modalPresentationStyle = UIModalPresentationStyle.Custom
			toViewController.transitioningDelegate = self.navTransitionOperator
			toViewController.presentingView = self
		}
		/*if segue.identifier == "presentEditProf" {
		if let editVC = segue.destinationViewController as? EditProfileViewController {
		self.modalPresentationStyle = UIModalPresentationStyle.Custom
		}
		}*/
	}
	
}

