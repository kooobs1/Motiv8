//
//  NavigationVC.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 7/29/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import Foundation
import UIKit

class NavigationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet var bgImageView: UIImageView!
	@IBOutlet var tableView: UITableView!
	@IBOutlet var dimmerView: UIView!
	
	var items: [NavigationModel]!
	var presentingView: UIViewController!
	//var defaults = NSUserDefaults.standardUserDefaults()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .None
		tableView.backgroundColor = UIColor.clearColor()
		bgImageView.image = UIImage(named: "nav-bg")
		dimmerView.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
		
		let home = NavigationModel(title: "Home", icon: "location")
		let rewards = NavigationModel(title: "Rewards", icon: "gift")
		let leaderboard = NavigationModel(title: "Leaderboard", icon: "leader")
		let about = NavigationModel(title: "About", icon: "icon-info")
		let signOut = NavigationModel(title: "Sign Out", icon: "door")
		
		items = [home, rewards, leaderboard, about, signOut]
		
		let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
		leftSwipe.direction = .Left
		view.addGestureRecognizer(leftSwipe)
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("NavigationCell") as! NavigationCell
		let item = items[indexPath.row]
		
		cell.titleLabel.text = item.title
		cell.countLabel.text = item.count
		cell.iconImageView.image = UIImage(named: item.icon)
		cell.backgroundColor = UIColor.clearColor()
		
		return cell
	}
	
	func handleSwipes(sender: UISwipeGestureRecognizer) {
		if sender.direction == .Left {
			dismissViewControllerAnimated(true, completion: nil)
		}
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		switch (indexPath.row) {
		case 0:
			if let _ = presentingView as? HomeViewController {
				dismissViewControllerAnimated(true, completion: nil)
			}
			else {
				self.performSegueWithIdentifier("presentHome", sender: self)
			}
		case 1:
			if let _ = presentingView as? RewardsViewController {
				dismissViewControllerAnimated(true, completion: nil)
			}
			else {
				self.performSegueWithIdentifier("presentRewards", sender: self)
			}
		case 2:
			if let _ = presentingView as? LeaderboardViewController {
				dismissViewControllerAnimated(true, completion: nil)
			}
			else {
				self.performSegueWithIdentifier("presentLeaderboard", sender: self)
			}
		case 3:
			if let _ = presentingView as? AboutViewController {
				dismissViewControllerAnimated(true, completion: nil)
			}
			else {
				self.performSegueWithIdentifier("presentAbout", sender: self)
			}
		default:
			print("fuckin up")
		}
	}
	
	/*func houseKeepingLogout() {
	self.performSegueWithIdentifier("unwindInitial", sender: self)
	NSUserDefaults.standardUserDefaults().removeObjectForKey("PixieUserId")
	NSUserDefaults.standardUserDefaults().removeObjectForKey("PixieUserFirstName")
	NSUserDefaults.standardUserDefaults().removeObjectForKey("PixieUserLastName")
	NSUserDefaults.standardUserDefaults().removeObjectForKey("PixieUserEmail")
	NSUserDefaults.standardUserDefaults().removeObjectForKey("PixieUserPassword")
	NSUserDefaults.standardUserDefaults().removeObjectForKey("PixieUserAge")
	NSUserDefaults.standardUserDefaults().removeObjectForKey("PixieUserBio")
	NSUserDefaults.standardUserDefaults().removeObjectForKey("PixieUserHasFB")
	NSUserDefaults.standardUserDefaults().removeObjectForKey("PixieUserProfPic")
	NSUserDefaults.standardUserDefaults().removeObjectForKey("PixieUserBlurredProfPic")
	NSUserDefaults.standardUserDefaults().removeObjectForKey("PicChange")
	
	Keychain.set(false, forKey: "loggedIn")
	PFUser.logOutInBackground()
	FBSession.activeSession().closeAndClearTokenInformation()
	}
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
	return .LightContent
	}*/
}

class NavigationModel {
	
	var title: String!
	var icon: String!
	var count: String?
	
	init(title: String, icon: String) {
		self.title = title
		self.icon = icon
	}
	
	init(title: String, icon: String, count: String) {
		self.title = title
		self.icon = icon
		self.count = count
	}
}

