//
//  Leaderboard.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 8/5/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import Foundation
import UIKit

// Represents a generic user. Need an image named "default"

class User
{
	var rank: Int
	var name: String
	var image: UIImage
	
	init(rank: Int, name: String, imageName: String)
	{
		self.rank = rank
		self.name = name
		if let img = UIImage(named: imageName) {
			image = img
		} else {
			image = UIImage(named: "default")!
		}
	}
}