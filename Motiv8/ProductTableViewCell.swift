//
//  ProductTableViewCell.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 8/3/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
	
	@IBOutlet weak var productImageView: UIImageView!
	@IBOutlet weak var productDescriptionLabel: UILabel!
	@IBOutlet weak var productTitleLabel: UILabel!
	
	func configureCellWith(product: Product)
	{
		productImageView.image = product.image
		productDescriptionLabel.text = product.description
		productTitleLabel.text = product.title
	}
	
}