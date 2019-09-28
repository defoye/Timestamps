//
//  TimestampViewDataTests.swift
//  TimestampsTests
//
//  Created by Ernest DeFoy on 9/27/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import XCTest
@testable import Timestamps

class TimestampViewDataTests: XCTestCase {
	
	func testDaysSince() {
		let timestampCellViewData = TimestampCellViewData(timestamp: Timestamp(title: "title1", date: Date()))

		XCTAssert(timestampCellViewData.daysSince() == 0)
	}
	
	func testD() {
		let yesterday = Date(timeInterval: -86400, since: Date())
		let tomorrow = Date(timeInterval: 86400, since: Date())
		
		
		XCTAssert(tomorrow.interval(ofComponent: .day, fromDate: yesterday) == 2)
	}
}
