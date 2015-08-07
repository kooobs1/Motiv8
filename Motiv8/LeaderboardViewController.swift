//
//  LeaderboardViewController.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 7/30/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var navTransitionOperator = NavigationTransitionOperator()
	@IBOutlet var tableView: UITableView!
	var user: User?
	
	let textCellIdentifier = "TextCell"
	
	//let swiftBlogs = ["Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		
		self.viewMoveInFromTop(tableView, animationTime: 1.8)
	}
	
	// MARK:  UITextFieldDelegate Methods
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//return swiftBlogs.count
		return LeaderboardViewController.rankUsers().count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
		
		let row = indexPath.row
		let users = LeaderboardViewController.rankUsers()
		//cell.textLabel?.text = swiftBlogs[row]
		cell.textLabel?.text = String(users[row].rank) + " " + users[row].name
		
		return cell
	}
	
	// MARK:  UITableViewDelegate Methods
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
		let row = indexPath.row
		//println(swiftBlogs[row])
	}
	
	private class func rankUsers() -> [User] {
		var users = [User]()
		
		users.append(User(rank: 1, name: "Kaveh Karimiyanha", imageName: ""))
		users.append(User(rank: 2, name: "Brian Fiumara", imageName: ""))
		users.append(User(rank: 3, name: "Steven Johnson", imageName: ""))
		users.append(User(rank: 4, name: "Jameson Quave", imageName: ""))
		users.append(User(rank: 5, name: "Kris Couch", imageName: ""))
		users.append(User(rank: 6, name: "Mike Evans", imageName: ""))
		users.append(User(rank: 7, name: "Taylor Swift", imageName: ""))
		users.append(User(rank: 8, name: "Andrew Bancroft", imageName: ""))
		users.append(User(rank: 9, name: "Johnny Appleseed", imageName: ""))
		users.append(User(rank: 10, name: "Meek Mill", imageName: ""))
		
		return users
	}
	
	func viewMoveInFromTop(view:UIView, animationTime:Float) {
		
		var animation:CATransition = CATransition()
		animation.duration = CFTimeInterval(animationTime)
		animation.type = "moveIn"
		animation.timingFunction = CAMediaTimingFunction(name: "easeInEaseOut")
		animation.subtype = "fromBottom"
		animation.fillMode = "forwards"
		view.layer.addAnimation(animation, forKey: nil)
		
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "presentNav" {
			let toViewController = segue.destinationViewController as! NavigationViewController
			self.modalPresentationStyle = UIModalPresentationStyle.Custom
			toViewController.transitioningDelegate = self.navTransitionOperator
			toViewController.presentingView = self
		}
	}
	
}