//
//  Product.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 8/3/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import Foundation
import UIKit

public enum ProductRating
{
	case Unrated
	case Average
	case OK
	case Good
	case Brilliant
}

// Represents a generic product. Need an image named "default"

class Product
{
	var title: String
	var description: String
	var image: UIImage
	var rating: ProductRating
	
	init(titled: String, description: String, imageName: String)
	{
		self.title = titled
		self.description = description
		if let img = UIImage(named: imageName) {
			image = img
		} else {
			image = UIImage(named: "default")!
		}
		rating = .Unrated
	}
}