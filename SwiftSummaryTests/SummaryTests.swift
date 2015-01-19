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
    
    func testSplitContentToParagraphs() {
        let paragraphs = ["Several", "Paragraphs", "Are", "In", "This", "Text"]
        let content = "\n\n".join(paragraphs)
    
        XCTAssert(summary.splitContentToParagraphs(content) == paragraphs)
    }

    func testSplitContentToSentences() {
        let sentences = ["This is a sentence.", "This is another sentence."]
        let content = " ".join(sentences)
        
        XCTAssert(summary.splitContentToSentences(content) == sentences)
    }
    
    func testSplitContentToWords() {
        let words = ["this", "is", "a", "sentence"]
        let content = " ".join(words)
        
        XCTAssert(summary.splitContentToWords(content) == words)
    }
    
    func testGetStringArrayIntersectionCaseInsensitive() {
        let array1 = ["hello", "testing", "TEST"]
        let array2 = ["HELLO", "testing", "test again"]
        
        let expectedResult = ["hello", "testing"]
        
        XCTAssert(summary.getStringArrayIntersectionCaseInsensitive(array1, arr2: array2) == expectedResult)
    }
    
    func testGetSentencesIntersectionScore() {
        //case 1: no words in either sentence
        XCTAssert( summary.getSentencesIntersectionScore("", sent2: "") == 0)
        
        //case 2: words in both sentences
        let sentence1 = "hello this is a sentence" //5 words
        let sentence2 = "THIS IS ANOTHER SENTENCE" //4 words
        
        let expectedIntersection = ["this", "is", "sentence"]
        
        let expectedScore = Float(expectedIntersection.count) / (Float(5+4) / 2)
        XCTAssert(summary.getSentencesIntersectionScore(sentence1, sent2: sentence2) == expectedScore)
    }
    
//    func testSummary() {
//        let bundle = NSBundle.mainBundle()
//        let path = bundle.pathForResource("test", ofType: "txt")
//        let content = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)
//        
//        print(summary.getSummary("Hello", content: content!))
//    }
    
//    func testFilter() {
//        var a = ["hello","hi"];
//        
//        var b = ["HELLO", "hi"];
//        
//        print(a.filter({contains(b.map({$0.lowercaseString}), $0.lowercaseString)}))
//    }
}
