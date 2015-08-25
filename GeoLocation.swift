//
//  GeoLocation.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 8/11/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

let kGeoLocationLatitudeKey = "latitude"
let kGeoLocationLongitudeKey = "longitude"
let kGeoLocationRadiusKey = "radius"
let kGeoLocationIdentifierKey = "identifier"
let kGeoLocationNoteKey = "note"
let kGeoLocationEventTypeKey = "eventType"

enum EventType: Int {
	case OnEntry = 0
	case OnExit
}

class GeoLocation: NSObject, NSCoding, MKAnnotation {
	var coordinate: CLLocationCoordinate2D
	var radius: CLLocationDistance
	var identifier: String
	var note: String
	var eventType: EventType
	
	var title: String {
		if note.isEmpty {
			return "No Note"
		}
		return note
	}
	
	var subtitle: String {
		var eventTypeString = eventType == .OnEntry ? "On Entry" : "On Exit"
		return "Radius: \(radius)m - \(eventTypeString)"
	}
	
	init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String, note: String, eventType: EventType) {
		self.coordinate = coordinate
		self.radius = radius
		self.identifier = identifier
		self.note = note
		self.eventType = eventType
	}
	
	// MARK: NSCoding
	
	required init(coder decoder: NSCoder) {
		let latitude = decoder.decodeDoubleForKey(kGeoLocationLatitudeKey)
		let longitude = decoder.decodeDoubleForKey(kGeoLocationLongitudeKey)
		coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		radius = decoder.decodeDoubleForKey(kGeoLocationRadiusKey)
		identifier = decoder.decodeObjectForKey(kGeoLocationIdentifierKey) as! String
		note = decoder.decodeObjectForKey(kGeoLocationNoteKey) as! String
		eventType = EventType(rawValue: decoder.decodeIntegerForKey(kGeoLocationEventTypeKey))!
	}
	
	func encodeWithCoder(coder: NSCoder) {
		coder.encodeDouble(coordinate.latitude, forKey: kGeoLocationLatitudeKey)
		coder.encodeDouble(coordinate.longitude, forKey: kGeoLocationLongitudeKey)
		coder.encodeDouble(radius, forKey: kGeoLocationRadiusKey)
		coder.encodeObject(identifier, forKey: kGeoLocationIdentifierKey)
		coder.encodeObject(note, forKey: kGeoLocationNoteKey)
		coder.encodeInt(Int32(eventType.rawValue), forKey: kGeoLocationEventTypeKey)
	}
}