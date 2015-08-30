//
//  ViewController.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 7/29/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

let kSavedItemsKey = "savedItems"

class HomeViewController: UIViewController, AddGeoLocationViewControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
	
	var navTransitionOperator = NavigationTransitionOperator()
	@IBOutlet weak var webViewBG: UIWebView!
	@IBOutlet weak var mapView: MKMapView!
	//var moviePlayer: MPMoviePlayerController?
	@IBOutlet weak var fitPoints: UILabel!
	@IBOutlet weak var totalPts: UILabel!
	var pts = 0
	var fitPts = 0
	var geolocations = [GeoLocation]()
	let locationManager = CLLocationManager()
	
	//var delegate: AddGeoLocationViewControllerDelegate!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		var filePath = NSBundle.mainBundle().pathForResource("motiv8gif", ofType: "gif")
		var gif = NSData(contentsOfFile: filePath!)
		
		webViewBG.loadData(gif, MIMEType: "image/gif", textEncodingName: nil, baseURL: nil)
		webViewBG.userInteractionEnabled = false
		
		var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
		
		// 1
		locationManager.delegate = self
		// 2
		locationManager.requestAlwaysAuthorization()
		// 3
		//onAdd()
		loadAllGeoLocations()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func update() {
		fitPoints.text = String(++pts)
		if (pts == 100) {
			totalPts.text = "Fit Points: " + String(++fitPts)
			pts  = 0
		}
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
	
	// MARK: Loading and saving functions
	
	/*private func onAdd() {
		var coordinate = mapView.centerCoordinate
		var radius = 20
		var identifier = NSUUID().UUIDString
		var note = "You are at the gym lil boy"
		var eventType = EventType.OnEntry //: EventType.OnExit
		//delegate!.addGeoLocationViewController(controller: AddGeoLocationViewController.self, didAddCoordinate: coordinate, radius: radius, identifier: identifier, note: note, eventType: eventType)
		print(coordinate.latitude)
		print(coordinate.longitude)
		GeoLocations = [GeoLocation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(38.027588), longitude: CLLocationDegrees(-122.556459)), radius: 1000, identifier: NSUUID().UUIDString, note: "You are at the gym lil boy", eventType: EventType.OnEntry)]
	}*/
	
	func loadAllGeoLocations() {
		geolocations = []
		
		if let savedItems = NSUserDefaults.standardUserDefaults().arrayForKey(kSavedItemsKey) {
			for savedItem in savedItems {
				if let geolocation = NSKeyedUnarchiver.unarchiveObjectWithData(savedItem as! NSData) as? GeoLocation {
					addGeoLocation(geolocation)
				}
			}
		}
		
		addGeoLocation(GeoLocation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(38.027588), longitude: CLLocationDegrees(-122.556459)), radius: CLLocationDistance(1000), identifier: NSUUID().UUIDString, note: "You are at the gym lil boy", eventType: EventType.OnEntry))
	}
	
	func saveAllGeoLocations() {
		var items = NSMutableArray()
		for GeoLocation in geolocations {
			let item = NSKeyedArchiver.archivedDataWithRootObject(GeoLocation)
			items.addObject(item)
		}
		NSUserDefaults.standardUserDefaults().setObject(items, forKey: kSavedItemsKey)
		NSUserDefaults.standardUserDefaults().synchronize()
	}
	
	// MARK: Functions that update the model/associated views with GeoLocation changes
	
	func addGeoLocation(geolocation: GeoLocation) {
		geolocations.append(geolocation)
		
		//next two lines
		mapView.addAnnotation(geolocation)
		addRadiusOverlayForGeoLocation(geolocation)
		updateGeoLocationsCount()
	}
	
	func removeGeoLocation(geolocation: GeoLocation) {
		if let indexInArray = find(geolocations, geolocation) {
			geolocations.removeAtIndex(indexInArray)
		}
		
		//next two lines
		mapView.removeAnnotation(geolocation)
		removeRadiusOverlayForGeoLocation(geolocation)
		updateGeoLocationsCount()
	}
	
	func updateGeoLocationsCount() {
		title = "GeoLocations (\(geolocations.count))"
		navigationItem.rightBarButtonItem?.enabled = (geolocations.count < 20)
	}
	
	// MARK: AddGeoLocationViewControllerDelegate
	
	func addGeoLocationViewController(controller: AddGeoLocationViewController, didAddCoordinate coordinate: CLLocationCoordinate2D, radius: Double, identifier: String, note: String, eventType: EventType) {
		controller.dismissViewControllerAnimated(true, completion: nil)
		// 1
		let clampedRadius = (radius > locationManager.maximumRegionMonitoringDistance) ? locationManager.maximumRegionMonitoringDistance : radius
		
		let geolocation = GeoLocation(coordinate: coordinate, radius: clampedRadius, identifier: identifier, note: note, eventType: eventType)
		addGeoLocation(geolocation)
		// 2
		startMonitoringGeoLocation(geolocation)
		
		saveAllGeoLocations()
	}
	
	// MARK: MKMapViewDelegate
	
	func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
		let identifier = "myGeoLocation"
		if annotation is GeoLocation {
			var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
			if annotationView == nil {
				annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
				annotationView?.canShowCallout = true
				var removeButton = UIButton.buttonWithType(.Custom) as! UIButton
				removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
				removeButton.setImage(UIImage(named: "DeleteGeoLocation")!, forState: .Normal)
				annotationView?.leftCalloutAccessoryView = removeButton
			} else {
				annotationView?.annotation = annotation
			}
			return annotationView
		}
		return nil
	}
	
	func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
		if overlay is MKCircle {
			print("here")
			var circleRenderer = MKCircleRenderer(overlay: overlay)
			circleRenderer.lineWidth = 1.0
			circleRenderer.strokeColor = UIColor.purpleColor()
			circleRenderer.fillColor = UIColor.purpleColor().colorWithAlphaComponent(0.4)
			return circleRenderer
		}
		return nil
	}
	
	func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
		// Delete GeoLocation
		var geolocation = view.annotation as! GeoLocation
		stopMonitoringGeoLocation(geolocation)
		removeGeoLocation(geolocation)
		saveAllGeoLocations()
	}
	
	// MARK: Map overlay functions
	
	func addRadiusOverlayForGeoLocation(geolocation: GeoLocation) {
		print("hello")
		//print(mapView.overlays.count)
		mapView?.addOverlay(MKCircle(centerCoordinate: geolocation.coordinate, radius: geolocation.radius))
		//overlayMe(mapView, rendererForOverlay: MKCircle(centerCoordinate: geolocation.coordinate, radius: geolocation.radius))
		//print(mapView.overlays.count)
	}
	
	func removeRadiusOverlayForGeoLocation(geolocation: GeoLocation) {
		// Find exactly one overlay which has the same coordinates & radius to remove
		if let overlays = mapView?.overlays {
			for overlay in overlays {
				if let circleOverlay = overlay as? MKCircle {
					var coord = circleOverlay.coordinate
					if coord.latitude == geolocation.coordinate.latitude && coord.longitude == geolocation.coordinate.longitude && circleOverlay.radius == geolocation.radius {
						mapView?.removeOverlay(circleOverlay)
						break
					}
				}
			}
		}
	}
	
	// MARK: Other mapview functions
	
	@IBAction func zoomToCurrentLocation(sender: AnyObject) {
		zoomToUserLocationInMapView(mapView)
	}
	
	func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
		mapView.showsUserLocation = (status == .AuthorizedAlways)
	}
	
	func regionWithGeoLocation(geolocation: GeoLocation) -> CLCircularRegion {
		// 1
		let region = CLCircularRegion(center: geolocation.coordinate, radius: geolocation.radius, identifier: geolocation.identifier)
		// 2
		region.notifyOnEntry = (geolocation.eventType == .OnEntry)
		region.notifyOnExit = !region.notifyOnEntry
		return region
	}
	
	func startMonitoringGeoLocation(geolocation: GeoLocation) {
		print("wassup")
		// 1
		if !CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion) {
			showSimpleAlertWithTitle("Error", message: "Geofencing is not supported on this device!", viewController: self)
			return
		}
		// 2
		if CLLocationManager.authorizationStatus() != .AuthorizedAlways {
			showSimpleAlertWithTitle("Warning", message: "Your GeoLocation is saved but will only be activated once you grant Motiv8 permission to access the device location.", viewController: self)
		}
		// 3
		let region = regionWithGeoLocation(geolocation)
		// 4
		locationManager.startMonitoringForRegion(region)
	}
	
	func stopMonitoringGeoLocation(geolocation: GeoLocation) {
		for region in locationManager.monitoredRegions {
			if let circularRegion = region as? CLCircularRegion {
				if circularRegion.identifier == geolocation.identifier {
					locationManager.stopMonitoringForRegion(circularRegion)
				}
			}
		}
	}
	
	func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
		println("Monitoring failed for region with identifier: \(region.identifier)")
	}
	
	func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
		println("Location Manager failed with the following error: \(error)")
	}
}