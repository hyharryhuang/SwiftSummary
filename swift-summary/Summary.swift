//
//  Summary.swift
//  swift-summary
//
//  Created by Harry Huang on 09/01/2015.
//  Copyright (c) 2015 HHH. All rights reserved.
//

import Foundation

class Summary {
    
    func splitContentToSentences(content:String) -> [String]
    {
        let replacedContent = content.stringByReplacingOccurrencesOfString("\n", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        return replacedContent.componentsSeparatedByString(". ")
    }
    
    func splitContentToParagraphs(content:String) -> [String]
    {
        return content.componentsSeparatedByString("\n\n");
    }
    
    func getSentencesIntersectionScore(sent1:String, sent2:String) -> Int
    {
        //split sentences to words
        let s1 = sent1.componentsSeparatedByString(" ");
        let s2 = sent2.componentsSeparatedByString(" ");
        
        //if no words, then score is 0.
        if s1.count + s2.count == 0
        {
            return 0
        }
        
        //find intersection elements between S1 and S2
        let s1InS2 = s1.filter { contains(s2, $0) }
        
        //score is the normalised intersection value
        return s1InS2.count / ((s1.count + s2.count)/2)
    }
    
    func formatSentence(sentence:String) -> String
    {
        let regex = NSRegularExpression(pattern:"\\W+", options: .CaseInsensitive, error: nil)
        let modifiedString = regex!.stringByReplacingMatchesInString(sentence, options: nil, range: NSRange(location: 0,length: countElements(sentence)), withTemplate: "")
        
        return modifiedString
    }

    func getSentenceRanks(content:String) -> [String:Int]
    {
        var sentences = splitContentToSentences(content)
        
        var n = sentences.count
        
        var values = [[Int]]()
        
        //calculate intersection of every two sentences
        
        for i in 0 ... n {
            var jValues = [Int]()
            
            for j in 0 ... n {
                jValues.append(getSentencesIntersectionScore(sentences[i], sent2: sentences[j]))
            }
            
            values.append(jValues)
        }
        
        //build overall sentence scores.
        //the overall score of a sentence is the sum of all its individual intersection scores.
        
        var sentencesDictionary = [String:Int]()
        
        for i in 0 ... n {
            var score = 0
            var jValues = [Int]()
            
            for j in 0 ... n {
                if(i == j)
                {
                    continue
                }
                
                score += values[i][j]
                
                jValues.append(getSentencesIntersectionScore(sentences[i], sent2: sentences[j]))
            }
            
            sentencesDictionary[formatSentence(sentences[i])] = score
        }
        
        return sentencesDictionary
    }
    
    //return the best sentence in a paragraph
    func getBestSentence(paragraph:String, sentencesDictionary:[String: Int]) -> String
    {
        //Split the paragraph into sentences
        var sentences = splitContentToParagraphs(paragraph)
        
        if(sentences.count < 2) {
            return ""
        }
        
        //Get best sentence according to the sentences dictionary
        var bestSentence = ""
        var maxValue = 0
        
        for s in sentences {
            var formatedSentence = formatSentence(s)
            
            if sentencesDictionary[formatedSentence] > maxValue
            {
                maxValue = sentencesDictionary[formatedSentence]!
                bestSentence = s
            }
        }
        
        return bestSentence
    }
    
    public func getSummary(title:String, content:String) -> String
    {
        var sentencesDictionary = getSentenceRanks(content)
        
        //split content into paragraphs
        var paragraphs = splitContentToParagraphs(content)
        
        //add title
        var summary = [String]()

        summary.append(title.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        summary.append("")
        
        for paragraph in paragraphs {
            var sentence = getBestSentence(paragraph, sentencesDictionary: sentencesDictionary)
            var trimmedSentence = sentence.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            if countElements(trimmedSentence) > 0 {
                summary.append(trimmedSentence)
            }
        }
        
        return "\n".join(summary)
    }
}
