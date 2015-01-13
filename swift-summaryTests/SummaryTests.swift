//
//  swift_summaryTests.swift
//  swift-summaryTests
//
//  Created by Harry Huang on 09/01/2015.
//  Copyright (c) 2015 HHH. All rights reserved.
//

import UIKit
import XCTest

class SummaryTests: XCTestCase {
    
    var summary = Summary()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSummary() {
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("test", ofType: "txt")
        let content = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)
        
//        let location = "~/test.txt".stringByExpandingTildeInPath
//        let text2 = String(contentsOfFile: location, encoding: NSUTF8StringEncoding, error: nil)
        
        print(summary.getSummary("hello", content: content!))
    }
}
