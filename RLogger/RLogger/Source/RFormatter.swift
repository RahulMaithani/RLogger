//
//  RFormatter.swift
//  RLogger
//
//  Created by Rahul Maithani on 04/04/21.
//

import Foundation

struct RFormatter {

    func formattedLog(_ level: FileLogger.Level, log: String,
        logThreadName: String, fileName: String, functionName: String, lineNumber: Int) -> String {
        let string = "[\(dateTimeFormDate(date: Date())) [\(level.rawValue)] \(nameOfFile(fileName)).\(functionName) [lineNumber: \(lineNumber)] \(log)"
        return string
    }
    
    func dateTimeFormDate(date: Date)-> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss.SSS"
        let dateString = inputFormatter.string(from: date)
        return dateString
    }
    
    func nameOfFile(_ file: String) -> String {
        let fileParts = file.components(separatedBy: "/")
        if let lastPart = fileParts.last {
            return lastPart
        }
        return ""
    }
}
