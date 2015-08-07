//
//  Product.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 8/3/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import Foundation
import UIKit

// Represents a generic product. Need an image named "default"

class Product
{
	var title: String
	var description: String
	var image: UIImage
	var deal1: String
	var deal2: String
	var deal3: String
	
	init(titled: String, description: String, imageName: String, deal1: String, deal2: String, deal3: String)
	{
		self.title = titled
		self.description = description
		if let img = UIImage(named: imageName) {
			image = img
		} else {
			image = UIImage(named: "default")!
		}
		self.deal1 = deal1
		self.deal2 = deal2
		self.deal3 = deal3
	}
}