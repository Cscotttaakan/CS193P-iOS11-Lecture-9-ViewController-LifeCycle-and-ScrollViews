//
//  ViewController.swift
//  Lecture 9 - Cassini
//
//  Created by Michel Deiman on 22/12/2017.
//  Copyright © 2017 Michel Deiman. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

	var imageURL: URL? {
		didSet {
			image = nil
			if view.window != nil { 	// we're on Screen!!
				fetchImage()
			}
		}
	}
	
	var image: UIImage? {
		get {
			return imageView.image
		}
		set {
			imageView.image = newValue
			imageView.sizeToFit()
			scrollView.contentSize = imageView.frame.size
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if imageView.image == nil {
			fetchImage()
		}
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
	
	@IBOutlet weak var scrollView: UIScrollView! {
		didSet {
			scrollView.minimumZoomScale = 1/25
			scrollView.maximumZoomScale = 1
			scrollView.delegate = self
			scrollView.addSubview(imageView)
		}
	}
	
	var imageView = UIImageView()
	
	private func fetchImage() {
		if let url = imageURL {
			let urlContents = try? Data(contentsOf: url)
			if let imageData = urlContents {
				image = UIImage(data: imageData)
			}
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		if imageURL == nil {
			imageURL = DemoURLs.stanford
		}
	}



}

