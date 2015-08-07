//
//  EditTableViewController.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 8/3/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import Foundation
import UIKit

class EditTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	// Model:
	var product: Product?
	
	@IBOutlet weak var productImageView: UIImageView!
	@IBOutlet weak var productTitleLabel: UILabel!
	//@IBOutlet weak var productDescriptionTextView: UITextView!
	@IBOutlet weak var productDeal1: UIButton!
	@IBOutlet weak var productDeal2: UIButton!
	@IBOutlet weak var productDeal3: UIButton!
	
	// MARK: - VC Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Edit Product"
		productImageView.image = product?.image
		productTitleLabel.text = product?.title
		//productDescriptionTextView.text = product?.deal1
		productDeal1.setTitle(product?.deal1, forState: .Normal)
		productDeal2.setTitle(product?.deal2, forState: .Normal)
		productDeal3.setTitle(product?.deal3, forState: .Normal)
	}
	
	/*override func viewWillDisappear(animated: Bool) {
		product?.title = productTitleLabel.text
		product?.description = productDescriptionTextView.text
		product?.image = productImageView.image!
	}*/
	
	// MARK: - UITextFieldDelegate
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		// dismiss the keyboard
		textField.resignFirstResponder()
		return true
	}
	
	// MARK: - UIScrollViewDelegate
	
	/*override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
		productDescriptionTextView.resignFirstResponder()
	}*/
	
	// MARK: - Table View Interaction
	
	override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
		if indexPath.section == 0 && indexPath.row == 0 {
			return indexPath
		} else {
			return nil
		}
	}
	
	// MARK: - Image Picker Controller
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if indexPath.section == 0 && indexPath.row == 0
		{
			let picker = UIImagePickerController()
			picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary  // .Camera
			picker.allowsEditing = false
			picker.delegate = self
			presentViewController(picker, animated: true, completion: nil)
		}
	}
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
		let image = info[UIImagePickerControllerOriginalImage] as! UIImage
		product?.image = image
		productImageView.image = image
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		if let identifier = segue.identifier {
			switch identifier {
			case "presentTest1":
				if let testVC = segue.destinationViewController as? TestViewController {
					self.modalPresentationStyle = UIModalPresentationStyle.Custom
				}
			case "presentTest2":
				if let testVC = segue.destinationViewController as? TestViewController {
					self.modalPresentationStyle = UIModalPresentationStyle.Custom
				}
			case "presentTest3":
				if let testVC = segue.destinationViewController as? TestViewController {
					self.modalPresentationStyle = UIModalPresentationStyle.Custom
				}
			default: break
			}
		}
	}
	
	@IBAction func unwindToEdit (segue : UIStoryboardSegue) {}
}