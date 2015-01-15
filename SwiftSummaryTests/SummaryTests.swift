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
    
//    func testSplitContentToParagraphs() {
//        let paragraphs = ["Several", "Paragraphs", "Are", "In", "This", "Text"]
//        let content = "\n\n".join(paragraphs)
//    
//        XCTAssert(summary.splitContentToParagraphs(content) == paragraphs)
//    }
//    
//    func testSplitContentToSentences() {
//        let sentences = ["This is a sentence", " This is another sentence", "\nand one with a break."]
//        let content = ". ".join(sentences)
//        
//        println(summary.splitContentToSentences(content))
//        
//    }
    
    func testSummary() {
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("test", ofType: "txt")
        let content = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)
        
        print(summary.getSummary("Hello", content: content!))
    }
    
//    func testFilter() {
//        var a = ["hello","hi"];
//        
//        var b = ["HELLO", "hi"];
//        
//        print(a.filter({contains(b.map({$0.lowercaseString}), $0.lowercaseString)}))
//    }
}