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
		configureDayTextView()
	}
	
	
}

extension TimestampCell {
	
	// MARK: - Helpers.
	
	private func addSubviews() {
		self.contentView.addSubview(dayTextView)
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
	}
	
	private func configureDayTextView() {
		dayTextView.backgroundColor = .white
		dayTextView.font = UIFont.systemFont(ofSize: 40)
	}
}
