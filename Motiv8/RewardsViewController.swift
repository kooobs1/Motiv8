//
//  RewardsVC.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 7/30/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import Foundation
import UIKit

class RewardsViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
	
	var navTransitionOperator = NavigationTransitionOperator()
	
	// MARK: - VC Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//navigationItem.rightBarButtonItem = editButtonItem()
		
		// Make the row height dynamic
		tableView.estimatedRowHeight = tableView.rowHeight
		tableView.rowHeight = UITableViewAutomaticDimension
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		tableView.reloadData()
	}
	
	
	// MARK: - Data Source
	
	lazy var productLines: [ProductLine] = {
		return ProductLine.productLines()
		}()
	
	var productShown = [Bool](count: ProductLine.numberOfProducts, repeatedValue: false)
	
	// MARK: - UITableViewDataSource
	
	override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let productLine = productLines[section]
		return productLine.name
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return productLines.count
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let productLine = productLines[section]
		return productLine.products.count   // the number of products in the section
	}
	
	// indexPath: which section and which row
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Product Cell", forIndexPath: indexPath) as! ProductTableViewCell
		
		let productLine = productLines[indexPath.section]
		let product = productLine.products[indexPath.row]
		
		cell.configureCellWith(product)
		
		return cell
	}
	
	// MARK: - Edit Tableview
	
	/*override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == UITableViewCellEditingStyle.Delete {
			let productLine = productLines[indexPath.section]
			productLine.products.removeAtIndex(indexPath.row)
			// tell the table view to update with new data source
			//            tableView.reloadData()    Bad way!
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
		}
	}*/
	
	// MARK: - Animate Table View Cell
	
	override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
	{
		// first
		
		if productShown[indexPath.row] == false {
			
			let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
			cell.layer.transform = rotationTransform
			
			UIView.animateWithDuration(1.0, animations: { () -> Void in
				
				cell.layer.transform = CATransform3DIdentity
				
			})
			
			productShown[indexPath.row] = true
			
		}
	}
	
	
	// performSegueWithIdentifier(identifier: "", sender: AnyObject?)
	// MARK: - Navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		if let identifier = segue.identifier {
			switch identifier {
			case "presentDetail":
				let productDetailVC = segue.destinationViewController as! ProductDetailViewController
				if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell) {
					productDetailVC.product = productAtIndexPath(indexPath)
				}
			case "presentEdit":
				let editTableVC = segue.destinationViewController as! EditTableViewController
				if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell) {
					editTableVC.product = productAtIndexPath(indexPath)
				}
			case "presentNav":
				let toViewController = segue.destinationViewController as! NavigationViewController
				self.modalPresentationStyle = UIModalPresentationStyle.Custom
				toViewController.transitioningDelegate = self.navTransitionOperator
				toViewController.presentingView = self
			default: break
			}
		}
	}
	
	// MARK: - Helper Method
	
	func productAtIndexPath(indexPath: NSIndexPath) -> Product
	{
		let productLine = productLines[indexPath.section]
		return productLine.products[indexPath.row]
	}
	
	/*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "presentNav" {
			let toViewController = segue.destinationViewController as! NavigationViewController
			self.modalPresentationStyle = UIModalPresentationStyle.Custom
			toViewController.transitioningDelegate = self.navTransitionOperator
			toViewController.presentingView = self
		}
	}*/
	
}