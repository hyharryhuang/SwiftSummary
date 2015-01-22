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
    
    func testGetStringArrayIntersectionCaseInsensitive() {
        let array1 = ["hello", "testing", "TEST"]
        let array2 = ["HELLO", "testing", "test again"]
        
        let expectedResult = ["hello", "testing"]
        
        XCTAssert(summary.getStringArrayIntersectionCaseInsensitive(array1, arr2: array2) == expectedResult)
    }
    
    func testGetBestSentence() {
        //Case 1: If less than two sentences in a paragraph, expect empty string.
        let paragraph1 = "Hello this is a sentence. And another one."
        XCTAssert(summary.getBestSentence(paragraph1, sentencesDictionary: [String:Float]()) == "")
        
        //Case 2: More than two sentences, expect best ranked one.
        let paragraph2 = "This is a sentence. And another one. And this is also one."
        let testSentencesDictionary = ["Thisisasentence" : Float(3), "Andanotherone" : Float(2), "Andthisisalsoone" : Float(0)];
        XCTAssert(summary.getBestSentence(paragraph2, sentencesDictionary: testSentencesDictionary) == "This is a sentence.")
        
        //Case 3: More than two sentences, but sentence dictionary does not contain any relevant ranks.
        let paragraph3 = "This is a sentence. And another one. And this is also one."
        let testSentencesDictionary2 = ["Something" : Float(3), "SomethingElse" : Float(2), "OneMore" : Float(0)];
        XCTAssert(summary.getBestSentence(paragraph3, sentencesDictionary: testSentencesDictionary2) == "")
    }
}
