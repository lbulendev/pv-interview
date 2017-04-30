//: Playground - noun: a place where people can play

import Cocoa

enum CommonSubstringError: Error {
    case arrayLength
    var arrayLengthDescription: String {
        return "Needs more than 1 string to compare"
    }
    case stringLengthTooShort
    var stringLengthTooShortDescription: String {
        return "The string is too short"
    }
}

func longestCommonSubstring(_ leftString: String, _ rightString: String) throws -> Int {
    guard leftString.characters.count > 0 && rightString.characters.count > 0 else {
        throw CommonSubstringError.stringLengthTooShort
    }
    
    let m = leftString.characters.count+1
    let n = rightString.characters.count+1
    var LCSuff: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)
    var result = 0
    
    for i in 0..<m {
        for j in 0..<n {
            if (i == 0 || j == 0) {
                LCSuff[i][j] = 0
            } else if (leftString[leftString.index(leftString.startIndex, offsetBy:i-1)] ==
                rightString[rightString.index(rightString.startIndex, offsetBy:j-1)]) {
                LCSuff[i][j] = LCSuff[i-1][j-1] + 1
                result = max(result, LCSuff[i][j])
            } else {
                LCSuff[i][j] = 0
            }
        }
    }
    return result
}

func longestCommonSubstring2(_ inString: [String]) throws -> Int {
    guard inString.count > 1 else {
        throw CommonSubstringError.arrayLength
    }
    var result = 0
    var currentResult = 0
    var firstPass = true
    
    var leftString = inString[0]
    let m = leftString.characters.count+1
    guard leftString.characters.count > 0 else {
        throw CommonSubstringError.stringLengthTooShort
    }
    
    for arrayIndex in 1..<inString.count {
        var rightString = inString[arrayIndex]
        let n = rightString.characters.count+1
        guard rightString.characters.count > 0 else {
            throw CommonSubstringError.stringLengthTooShort
        }
        
        var LCSuff: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)
        
        for i in 0..<m {
            for j in 0..<n {
                if (i == 0 || j == 0) {
                    LCSuff[i][j] = 0
                } else if (leftString[leftString.index(leftString.startIndex, offsetBy:i-1)] ==
                    rightString[rightString.index(rightString.startIndex, offsetBy:j-1)]) {
                    LCSuff[i][j] = LCSuff[i-1][j-1] + 1
                    currentResult = max(currentResult, LCSuff[i][j])
                } else {
                    LCSuff[i][j] = 0
                }
            }
        }
        if (firstPass) {
            result = currentResult
            firstPass = false
            currentResult = 0
        } else {
            result = min(result, currentResult)
        }
    }
    return result
}

func firstLCS(_ leftString: String, _ rightString: String) {
    do {
        print( try longestCommonSubstring(leftString, rightString))
    }
    catch {
        print(CommonSubstringError.stringLengthTooShort.stringLengthTooShortDescription)
    }
}

func secondLCS(_ inString: [String]) {
    do {
        print(try longestCommonSubstring2(inString))
    }
    catch {
        print(CommonSubstringError.arrayLength.arrayLengthDescription)
    }
}

firstLCS("OldSite:GeeksforGeeks.org", "NewSite:GeeksQuiz.com")
firstLCS("GeeksforGeeks.org", "GeeksQuiz.com")
firstLCS("alphabet", "closet")
firstLCS("a", "b")
firstLCS("apple", "elppa")
firstLCS("apple", "")
firstLCS("", "elppa")
secondLCS(["able"])
secondLCS(["able", "baker"])
secondLCS(["able", "baker", "charlie"])
secondLCS(["able", "able"])
secondLCS(["able", ""])
secondLCS(["", "able"])
secondLCS(["OldSite:GeeksforGeeks.org", "NewSite:GeeksQuiz.com"])
secondLCS(["OldSite:GeeksforGeeks.org", "NewSite:GeeksQuiz.com", "Geeks"])
secondLCS(["Geeks", "OldSite:GeeksforGeeks.org", "NewSite:GeeksQuiz.com"])
secondLCS(["able", "baker", "charlie"])
firstLCS("able", "baker")
firstLCS("baker", "charlie")
firstLCS("able", "charlie")
secondLCS(["abc", "cbs", "abs", "tbn"])
secondLCS(["even", "eleven", "ten", "green"])
