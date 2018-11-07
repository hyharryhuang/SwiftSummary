//
//  Summary.swift
//  SwiftSummary
//
//  Created by Harry Huang on 09/01/2015.
//  Copyright (c) 2015 HHH. All rights reserved.
//

import Foundation

public class Summary {
    
    func splitContentToSentences(content:String) -> [String]
    {
        return splitContent(content: content, enumerationOption: NSString.EnumerationOptions.bySentences)
    }
    
    func splitContentToParagraphs(content:String) -> [String]
    {
        return splitContent(content: content, enumerationOption: NSString.EnumerationOptions.byParagraphs)
    }
    
    func splitContentToWords(content:String) -> [String]
    {
        if(countElements(item: content) == 0)
        {
            return []
        } else {
            return content.components(separatedBy: " ")
            //        return splitContent(content, enumerationOption: NSStringEnumerationOptions.ByWords)
        }
    }
    
    func splitContent(content:String, enumerationOption:NSString.EnumerationOptions) -> [String]
    {
        let contentString = content as NSString
        
        var splitContent = [String]()
        
        contentString.enumerateSubstrings(in: NSMakeRange(0, (contentString as NSString).length), options: enumerationOption) { (splitString, substringRange, enclosingRange, stop) -> () in
            
            let trimmedString = splitString?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //remove blank lines
            if(self.countElements(item: trimmedString!) > 0)
            {
                splitContent.append(trimmedString!)
            }
        }
        
        return splitContent
    }
    
    func getSentencesIntersectionScore(sent1:String, sent2:String) -> Float
    {
        //split sentences to words
        let s1 = splitContentToWords(content: sent1)
        let s2 = splitContentToWords(content: sent2)
        
        //if no words, then score is 0.
        if s1.count + s2.count == 0
        {
            return 0
        }
        
        //find intersection elements between S1 and S2
        let s1InS2 = getStringArrayIntersectionCaseInsensitive(arr1: s1, arr2: s2)
        
        //score is the normalised intersection value
        return Float(s1InS2.count) / (Float(s1.count + s2.count)/2.0)
    }
    
    func getStringArrayIntersectionCaseInsensitive(arr1:[String], arr2:[String]) -> [String]
    {
        let lowerCaseArr2 = arr2.map({$0.lowercased()})
        
        return arr1.filter({ lowerCaseArr2.contains($0.lowercased()) })
    }
    
    func formatSentence(sentence:String) -> String
    {
        do {
            let regex = try NSRegularExpression(pattern: "\\W+", options: .caseInsensitive)
            let modifiedString = regex.stringByReplacingMatches(in: sentence, options: [], range: NSRange(location: 0,length: countElements(item: sentence)), withTemplate: "")
            
            return modifiedString
        } catch {
            return ""
        }
    }
    
    func getSentenceRanks(content:String) -> [String:Float]
    {
        var sentences = splitContentToSentences(content: content)
        
        var n = sentences.count
        
        var values = [[Float]]()
        
        //calculate intersection of every two sentences
        
        for i in 0 ... n-1 {
            var jValues = [Float]()
            
            for j in 0 ... n-1 {
                jValues.append(getSentencesIntersectionScore(sent1: sentences[i], sent2: sentences[j]))
            }
            
            values.append(jValues)
        }
        
        //build overall sentence scores.
        //the overall score of a sentence is the sum of all its individual intersection scores.
        
        var sentencesDictionary = [String:Float]()
        
        for i in 0 ... n-1 {
            var score:Float = 0.0
            var jValues = [Float]()
            
            for j in 0 ... n-1 {
                if(i == j)
                {
                    continue
                }
                
                score += values[i][j]
            }
            
            sentencesDictionary[formatSentence(sentence: sentences[i])] = score
        }
        
        return sentencesDictionary
    }
    
    //return the best sentence in a paragraph
    func getBestSentence(paragraph:String, sentencesDictionary:[String: Float]) -> String
    {
        //Split the paragraph into sentences
        var sentences = splitContentToSentences(content: paragraph)
        
        if(sentences.count < 2) {
            return ""
        }
        
        //Get best sentence according to the sentences dictionary
        var bestSentence = ""
        var maxValue:Float = 0.0
        
        for s in sentences {
            var formatedSentence = formatSentence(sentence: s)
            
            if(countElements(item: formatedSentence) > 0)
            {
                if sentencesDictionary[formatedSentence]! > maxValue
                {
                    maxValue = sentencesDictionary[formatedSentence]!
                    bestSentence = s
                }
            }
        }
        
        return bestSentence
    }
    
    public func getSummary(title:String, content:String) -> String
    {
        var sentencesDictionary = getSentenceRanks(content: content)
        
        //split content into paragraphs
        var paragraphs = splitContentToParagraphs(content: content)
        
        //add title
        var summary = [String]()
        
        summary.append(title.trimmingCharacters(in: .whitespacesAndNewlines) )
        summary.append("")
        
        for paragraph in paragraphs {
            var sentence = getBestSentence(paragraph: paragraph, sentencesDictionary: sentencesDictionary)
            var trimmedSentence = sentence.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if countElements(item: trimmedSentence) > 0 {
                summary.append(trimmedSentence)
            }
        }
        
        return summary.joined(separator: "\n\n")
    }
    
    func countElements(item : Any) -> Int {
        return (item as AnyObject).trimmingCharacters(in: .whitespacesAndNewlines).characters.count
    }
}
