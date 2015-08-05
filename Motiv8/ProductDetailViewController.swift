//
//  ProductDetailViewController.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 8/3/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController
{
	// Model
	var product: Product?
	
	@IBOutlet weak var productImageView: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		productImageView.image = product?.image
	}
	
}