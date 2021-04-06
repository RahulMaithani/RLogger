//
//  FileLogger.swift
//  RLogger
//
//  Created by Rahul Maithani on 04/04/21.
//

import UIKit

class FileLogger {
    
    private let fileManager = FileManager.default
    private let configuration: RLoggerConfiguration
    private let fileWriter: RFileWriter

    static var logger: FileLogger { return FileLogger() }
    
    public enum Level: String {
        case verbose = "VERBOSE"
        case debug = "DEBUG"
        case info = "INFO"
        case warning = "WARNING"
        case error = "ERROR"
    }
    
    private init() {
        self.configuration = RLoggerConfiguration(maxFileSize: RLogger.maxFileSize, maxNumberOfFiles: RLogger.maxNumberOfFiles, logFileName: RLogger.logFileName)
        fileWriter = RFileWriter(configuration: configuration, fileManager: fileManager)
    }

    class func debug(_ log: @autoclosure () -> String = "", _ lineNumber: Int = #line, _ functionName: String = #function, fileName: String = #file) {
        logger.fileWriter.saveToFile(level: .debug, log: log(), fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }
    
    class func verbose(_ log: @autoclosure () -> String = "", _ lineNumber: Int = #line, _ functionName: String, fileName: String = #file) {
        logger.fileWriter.saveToFile(level: .verbose, log: log(), fileName: fileName, functionName: functionName, lineNumber: lineNumber)

    }
    
    class func info(_ log: @autoclosure () -> String = "", _ lineNumber: Int = #line, _ functionName: String, fileName: String = #file) {
        logger.fileWriter.saveToFile(level: .info, log: log(), fileName: fileName, functionName: functionName, lineNumber: lineNumber)

    }
    
    class func warning(_ log: @autoclosure () -> String = "", _ lineNumber: Int = #line, _ functionName: String, fileName: String = #file) {
        logger.fileWriter.saveToFile(level: .warning, log: log(), fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }
    
    class func error(_ log: @autoclosure () -> String = "", _ lineNumber: Int = #line, _ functionName: String, fileName: String = #file) {
        logger.fileWriter.saveToFile(level: .error, log: log(), fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }
}
