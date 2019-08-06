//
//  UITextView+Helpers.swift
//  Timestamps
//
//  Created by Ernest DeFoy on 8/4/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

extension UITextView {
	
	static func constructDefaultTextView() -> UITextView {
		let textView = UITextView()
		
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.backgroundColor = .orange
		textView.isScrollEnabled = false
		textView.isPagingEnabled = false
		textView.isEditable = false
		textView.textAlignment = .center
		
		return textView
	}
}
