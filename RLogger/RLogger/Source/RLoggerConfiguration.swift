//
//  RLoggerConfiguration.swift
//  RLogger
//
//  Created by Rahul Maithani on 04/04/21.
//

import Foundation

struct RLoggerConfiguration {
    
    var maxFileSize = 1024 * 1024 * 1 // 1MB
    var maxNumberOfFiles = 5
    var logFileURL: URL?
    var logFileName: String
    var logThreadNName: String {

        if Thread.isMainThread {
            return ""
        } else {
            let name = __dispatch_queue_get_label(nil)
            return String(cString: name, encoding: .utf8) ?? Thread.current.description
        }
    }
    
    init(maxFileSize: Int = 1024 * 1024 * 1, maxNumberOfFiles: Int = 5, logFileName: String = "RLogger") {
        self.maxFileSize = maxFileSize
        self.maxNumberOfFiles = maxNumberOfFiles
        self.logFileName = logFileName
        logFileURL = getFilePathForSavingFile()
    }
    
    private mutating func getFilePathForSavingFile() -> URL {
        
        if logFileName.isEmpty {
            logFileName = "RLogger"
        }
        let fileName = "\(logFileName).log"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        print("File PAth: \(fileURL.path)")
        
        return fileURL
    }
}
