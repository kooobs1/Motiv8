//
//  ProductLine.swift
//  Motiv8
//
//  Created by Kaveh Karimiyanha on 8/3/15.
//  Copyright (c) 2015 Motiv8. All rights reserved.
//


import Foundation

class ProductLine
{
	// Variables
	var name: String            // name of the product line
	var products: [Product]     // all products in the line
	
	class var numberOfProducts: Int {
		get {
			return (ProductLine.Nutrition().products.count + ProductLine.Apparel().products.count + ProductLine.Food().products.count)// + ProductLine.iPod().products.count + ProductLine.iCloudAndApplePay().products.count)
		}
	}
	
	init(named: String, includeProducts: [Product])
	{
		name = named
		products = includeProducts
	}
	
	class func productLines() -> [ProductLine]
	{
		return [self.Nutrition(), self.Apparel(), self.Food()]//, self.iPod(), self.iCloudAndApplePay()]
	}
	
	// Private methods
	
	private class func Nutrition() -> ProductLine {
		//  (1) iDevices: Apple Watch, iPad, iPhone, iOS
		var products = [Product]()
		
		//jamba juice
		products.append(Product(titled: "Jamba Juice", description: "Jamba! Enriching the daily experience of our customers, our community and ourselves through the life-nourishing qualities of fruits and vegetables.", imageName: "Jamba-Juice.jpg", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//nutrishop
		products.append(Product(titled: "Nutrishop", description: "It is NUTRISHOP'S mission to help you succeed in all your health and fitness goals and aspirations.  Whether your goal is, weight loss, muscle growth, to tone-up, increase energy levels, improve general health or to simply look and feel better, we have what you are looking for.", imageName: "ns-logo.jpg", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//gnc
		products.append(Product(titled: "GNC", description: "GNC is the world's largest chain of specialty vitamin, mineral, herbal and sports nutritional supplement retailers.", imageName: "gnc.jpeg", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "iPad", description: "iPad Air 2 is the thinnest and most powerful iPad ever. With iPad, we’ve always had a somewhat paradoxical goal: to create a device that’s immensely powerful, yet so thin and light you almost forget it’s there.", imageName: "ipad-air2.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		
		return ProductLine(named: "Nutrition", includeProducts: products)
	}
	
	//  (2) Mac: MacBook, MacBook Pro with Retina Display, MacBook Air, iMac
	//           Mac Pro, MacBook Pro, Mac Mini, Display, Airport Extreme,
	//           AirPort Time Capsule, AirPort Express, Magic Trackpad
	//           Magic Mouse, Apple Keyboard, Apple Battery Charger
	
	private class func Apparel() -> ProductLine
	{
		var products = [Product]()
		
		//sports authority
		products.append(Product(titled: "Sports Authority", description: "Our customers are passionate about the sports they pursue—they want to run faster, jump higher, hit the ball harder, carry their team to victory, and more. We understand the passion that comes with being dedicated to a goal.", imageName: "sportsauthority.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//sports forum
		products.append(Product(titled: "Sports Forum", description: "We're locally owned and operated business, we carry clothing, hats, official jerseys and more!!! for all NFL, NBA and MLB professional sports teams.", imageName: "sportsforum.jpg", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//lululemon
		products.append(Product(titled: "Lululemon", description: "Creating components for people to live longer, healthier, fun lives.", imageName: "Lululemon.jpg", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		
		//products.append(Product(titled: "MacBook", description: "The thinnest and lightest Mac ever with every component meticulously redesigned to create a Mac that is just two pounds and 13.1 mm thin. ", imageName: "macbook.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "MacBook Pro 13 inch", description: "MacBook Pro features the latest dual-core and quad-core processors, and faster graphics to deliver the perfect combination of pro performance and extreme portability.", imageName: "macbook-pro-13.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "MacBook Pro with Retina Display", description: "A stunning high-resolution display, an amazing thin and light design, and the latest technology to power through the most demanding projects.", imageName: "macbook-pro-retina.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "MacBook Air", description: "All day battery life, fourth generation Intel Core processors with faster graphics, 802.11ac Wi-Fi and flash storage that is up to 45 percent faster than the previous generation.", imageName: "macbook-air.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "iMac", description: "The 27-inch iMac with Retina 5K display features a breathtaking 14.7 million pixel display so text appears sharper than ever, videos are unbelievably lifelike.", imageName: "imac-5k.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "Mac Pro", description: "Designed around a revolutionary unified thermal core, the Mac Pro introduces a completely new pro desktop architecture and design that is optimized for performance inside and out.", imageName: "mac-pro.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "Mac Mini", description: "With its sleek aluminum design, a removable bottom panel for easy access to memory, and a space-saving built-in power supply, Mac mini is pretty incredible.", imageName: "mac-mini.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "Displays", description: "The 27-inch Apple LED Cinema Display supersizes your view with an incredible 2560-by-1440 resolution.", imageName: "display.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "Airport Extreme", description: "Featuring 802.11ac Wi-Fi for up to three times faster performance.", imageName: "airport-extreme.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		
		return ProductLine(named: "Apparel", includeProducts: products)
	}
	
	//  (3) Software: OS X, iLife, iWork, Logic Pro X, Final Cut Pro X, Aperture
	
	private class func Food() -> ProductLine
	{
		var products = [Product]()
		
		//urbane
		products.append(Product(titled: "Urbane Cafe", description: "We believe that a truly enjoyable dining experience requires fast, friendly service and a warm, inviting environment. As a family-owned company that cares for our employees and the communities we serve, we hope our cafes reflect these values.", imageName: "Urbane.jpg", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//boba
		products.append(Product(titled: "Boba", description: "Boba is a Taiwanese tea-based drink invented in Taichung in the 1980s.", imageName: "boba.jpg", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		
		//products.append(Product(titled: "OS X", description: "Built on a rock-solid UNIX foundation, OS X is engineered to take full advantage of the technologies in every new Mac.", imageName: "os-x.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "iLife", description: "Do more with movies and music than you ever thought possible.", imageName: "ilife.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "iWork", description: " iWork is the easiest way to create great-looking documents, spreadsheets, and presentations. ", imageName: "iwork.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "Logic Pro X", description: "Logic Pro X, the most advanced version of Logic Pro to date, with a new interface designed for pros.", imageName: "logic-pro-x.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "Final Cut Pro X", description: "A revolutionary new version of the world’s most popular Pro video editing software which completely reinvents video editing.", imageName: "final-cut-pro-x.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		//products.append(Product(titled: "Aperture", description: "Featuring revolutionary new technologies and a pioneering user interface with a beautiful design that honors the rich tradition of precision watchmaking.", imageName: "aperture.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		
		return ProductLine(named: "Food", includeProducts: products)
	}
	
	//  (4) iPod: Apple TV, iPod nano, iPod shuffle, iPod touch, iTunes
	
	private class func iPod() -> ProductLine
	{
		var products = [Product]()
		
		products.append(Product(titled: "iPod nano", description: "The thinnest iPod ever featuring a 2.5-inch Multi-Touch display; convenient navigation buttons; built-in Bluetooth for wireless listening; and the iPod nano comes in seven gorgeous colors.", imageName: "ipod-nano.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		products.append(Product(titled: "iPod shuffle", description: "Crafted from a single piece of aluminium and polished to a beautiful shine, iPod shuffle feels solid, sleek and durable.", imageName: "ipod-shuffle.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		products.append(Product(titled: "iPod touch", description: "Featuring a brilliant 4-inch Retina display; a 5-megapixel iSight camera with 1080p HD video recording.", imageName: "ipod-touch.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		products.append(Product(titled: "iTunes", description: "A free application for your Mac or PC, iTunes organizes and plays your digital music and video on your computer.", imageName: "itunes.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		products.append(Product(titled: "Apple TV", description: "Access to tons of great HD content in a tiny package. Enjoy blockbuster movies, TV shows, live sports and news, your music, photos, and more — right on your high-definition TV.", imageName: "apple-tv.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		
		return ProductLine(named: "iPod and iTunes", includeProducts: products)
	}
	
	//  (5) Services: iCloud, Apple Pay
	
	private class func iCloudAndApplePay() -> ProductLine
	{
		var products = [Product]()
		
		products.append(Product(titled: "iCloud", description: "The thinnest iPod ever featuring a 2.5-inch Multi-Touch display; convenient navigation buttons; built-in Bluetooth for wireless listening; and the iPod nano comes in seven gorgeous colors.", imageName: "icloud.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		products.append(Product(titled: "Apple Pay", description: "A breakthrough set of free new cloud services that work seamlessly with applications on your iPhone®, iPad®, iPod touch®, Mac® or PC to automatically and wirelessly store your content in iCloud and automatically and wirelessly push it to all your devices. ", imageName: "apple-pay.png", deal1: "15 pts - 10% off storewide", deal2: "20 pts - 15% off storewide", deal3: "25 pts - 20% off storewide\n"))
		
		return ProductLine(named: "iCloud and Apple Pay", includeProducts: products)
	}
}