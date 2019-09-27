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
		if let date = viewData.timestamp.date {
			configureDateTextView(date: date)
		}
	}
}

extension TimestampCell {
	
	// MARK: - Helpers.
	
	private func addSubviews() {
		self.contentView.addSubview(dayTextView)
		self.contentView.addSubview(titleTextView)
	}
	
	private func setupConstraints() {
		
		// dayTextView constraints.
		dayTextView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[dayTextView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
			 dayTextView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
			 dayTextView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.90),
			 dayTextView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25)]
		)
		
		// titleTextView constraints.
		titleTextView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[titleTextView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
			 titleTextView.leftAnchor.constraint(equalTo: self.dayTextView.rightAnchor, constant: 10),
			 titleTextView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.90),
			 titleTextView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10)]
		)
	}
	
	private func configureDateTextView(date: Date) {
		dayTextView.backgroundColor = .white
		dayTextView.font = UIFont.systemFont(ofSize: 18)
		dayTextView.textAlignment = .center
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM dd,yyyy"
		dayTextView.text = "\n" + dateFormatter.string(from: date)
	}
	
	private func configureTitleTextView(title: String) {
		titleTextView.backgroundColor = .white
		titleTextView.font = UIFont.systemFont(ofSize: 40)
		titleTextView.text = title
	}
}
