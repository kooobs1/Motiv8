//
//  AddGeoLocationViewController.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 8/19/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import UIKit
import MapKit

protocol AddGeoLocationViewControllerDelegate {
	func addGeoLocationViewController(controller: AddGeoLocationViewController, didAddCoordinate coordinate: CLLocationCoordinate2D,
		radius: Double, identifier: String, note: String, eventType: EventType)
}

class AddGeoLocationViewController: UITableViewController {
	
	@IBOutlet var addButton: UIBarButtonItem!
	@IBOutlet var zoomButton: UIBarButtonItem!
	
	@IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
	@IBOutlet weak var radiusTextField: UITextField!
	@IBOutlet weak var noteTextField: UITextField!
	@IBOutlet weak var mapView: MKMapView!
	
	var delegate: AddGeoLocationViewControllerDelegate!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItems = [addButton, zoomButton]
		addButton.enabled = false
		
		tableView.tableFooterView = UIView()
	}
	
	@IBAction func textFieldEditingChanged(sender: UITextField) {
		addButton.enabled = !radiusTextField.text!.isEmpty && !noteTextField.text!.isEmpty
	}
	
	@IBAction func onCancel(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	/*@IBAction private func onAdd(sender: AnyObject) {
		var coordinate = mapView.centerCoordinate
		var radius = (radiusTextField.text as NSString).doubleValue
		var identifier = NSUUID().UUIDString
		var note = noteTextField.text
		var eventType = (eventTypeSegmentedControl.selectedSegmentIndex == 0) ? EventType.OnEntry : EventType.OnExit
		delegate!.addGeoLocationViewController(self, didAddCoordinate: coordinate, radius: radius, identifier: identifier, note: note, eventType: eventType)
	}*/
	
	@IBAction private func onZoomToCurrentLocation(sender: AnyObject) {
		zoomToUserLocationInMapView(mapView)
	}
}