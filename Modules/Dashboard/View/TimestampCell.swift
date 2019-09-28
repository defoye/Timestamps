//
//  TimestampCell.swift
//  Timestamps
//
//  Created by Ernest DeFoy on 8/4/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import TableauxUI

public class TimestampCell: UITableViewCell {
	
	let dayTextView = UITextView.constructDefaultTextView()
	let titleTextView = UITextView.constructDefaultTextView()
	let daysSinceTextView = UITextView.constructDefaultTextView()
	
	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.selectionStyle = .none
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension TimestampCell: TableauCellProtocol {
	public func configure<T>(data: T) {
		self.backgroundColor = .orange
		
		addSubviews()
		setupConstraints()
		
		if let viewData = data as? TimestampCellViewData {
			configureWith(viewData: viewData)
		}
	}
	
	private func configureWith(viewData: TimestampCellViewData) {
		if let title = viewData.timestamp.title {
			configureTitleTextView(title: title)
		}
		if let days = viewData.daysSince() {
			configureDateTextView(days: days)
		}
		configureDaysSinceTextView()
	}
}

extension TimestampCell {
	
	// MARK: - Helpers.
	
	private func addSubviews() {
		self.contentView.addSubview(dayTextView)
		self.contentView.addSubview(titleTextView)
		self.contentView.addSubview(daysSinceTextView)
	}
	
	private func setupConstraints() {
		
		// dayTextView constraints.
		dayTextView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[dayTextView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
			 dayTextView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10)]
		)
		
		// daysSinceTextView constraints.
		daysSinceTextView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[daysSinceTextView.topAnchor.constraint(equalTo: self.dayTextView.bottomAnchor, constant: 10),
			 daysSinceTextView.leftAnchor.constraint(equalTo: self.dayTextView.leftAnchor),
			 daysSinceTextView.rightAnchor.constraint(equalTo: self.dayTextView.rightAnchor)]
		)
		
		// titleTextView constraints.
		titleTextView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[titleTextView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
			 titleTextView.leftAnchor.constraint(equalTo: self.dayTextView.rightAnchor, constant: 10),
			 titleTextView.bottomAnchor.constraint(equalTo: self.dayTextView.bottomAnchor),
			 titleTextView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10)]
		)
	}
	
	private func configureDateTextView(days: Int) {
		let fixedWidth = dayTextView.frame.size.width
		let newSize = dayTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
		dayTextView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
		dayTextView.backgroundColor = .white
		dayTextView.font = UIFont.systemFont(ofSize: 74)
		dayTextView.textAlignment = .center
		dayTextView.text = String(days)
	}
	
	private func configureDaysSinceTextView() {
		let fixedWidth = daysSinceTextView.frame.size.width
		let newSize = daysSinceTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
		daysSinceTextView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
		daysSinceTextView.backgroundColor = .white
		daysSinceTextView.font = UIFont.systemFont(ofSize: 14)
		daysSinceTextView.textAlignment = .center
		daysSinceTextView.text = "Days since"
	}
	
	private func configureTitleTextView(title: String) {
		titleTextView.backgroundColor = .white
		titleTextView.font = UIFont.systemFont(ofSize: 40)
		titleTextView.text = title
	}
}
