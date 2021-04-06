//
//  RLogger.swift
//  RLogger
//
//  Created by Rahul Maithani on 04/04/21.
//

import Foundation

public class RLogger {
    
    static let logger = FileLogger.self
    static var maxFileSize = 1024 * 1024 * 1
    static var maxNumberOfFiles = 5
    static var logFileName: String = "RLogger"

    @objc open class func verbose(_ log: String, _ lineNumber: Int = #line, _ functionName: String = #function, fileName: String = #file) {
        logger.verbose(log, lineNumber, functionName, fileName: fileName)
    }
    
    @objc open class func info(_ log: String, _ lineNumber: Int = #line, _ functionName: String = #function, fileName: String = #file) {
        logger.info(log, lineNumber, functionName, fileName: fileName)
    }
    
    @objc open class func debug(_ log: String, _ lineNumber: Int = #line, _ functionName: String = #function, fileName: String = #file) {
        logger.debug(log, lineNumber, functionName, fileName: fileName)
    }
    
    @objc open class func warning(_ log: String, _ lineNumber: Int = #line, _ functionName: String = #function, fileName: String = #file) {
        logger.warning(log, lineNumber, functionName, fileName: fileName)
    }
    
    @objc open class func error(_ log: String, _ lineNumber: Int = #line, _ functionName: String = #function, fileName: String = #file) {
        logger.error(log, lineNumber, functionName, fileName: fileName)
    }
}
