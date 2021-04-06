//
//  RFileWriter.swift
//  RLogger
//
//  Created by Rahul Maithani on 04/04/21.
//

import Foundation

class RFileWriter {
    
    private let fileManager: FileManager
    private let configuration: RLoggerConfiguration
    private let formatter: RFormatter
    private let fileRolling: RFileRolling
    init(configuration: RLoggerConfiguration, fileManager: FileManager) {
        
        self.configuration = configuration
        self.fileManager = fileManager
        self.formatter = RFormatter()
        self.fileRolling = RFileRolling(configuration: configuration)
        self.log(logFileURL: configuration.logFileURL)
    }
    
    private func log(logFileURL: URL?) {
        
        guard let url = logFileURL else { return }
        let data = "".data(using: String.Encoding.utf8)
        if !fileManager.fileExists(atPath: url.path) {
            fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
        }
    }
    
    open func saveToFile( level: FileLogger.Level, log: String, fileName: String, functionName: String, lineNumber: Int) {
        guard let url = configuration.logFileURL else { return  }
        let formattedLog = formatter.formattedLog(level, log: log, logThreadName: configuration.logThreadNName, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
        let line = formattedLog + "\n"
        guard let data = line.data(using: String.Encoding.utf8) else { return  }
        
        do {
            if fileManager.fileExists(atPath: url.path) == false {
                
                let directoryURL = url.deletingLastPathComponent()
                if fileManager.fileExists(atPath: directoryURL.path) == false {
                    try fileManager.createDirectory(
                        at: directoryURL,
                        withIntermediateDirectories: true
                    )
                }
                fileManager.createFile(atPath: url.path, contents: nil)
                
                #if os(iOS) || os(watchOS)
                if #available(iOS 10.0, watchOS 3.0, *) {
                    var attributes = try fileManager.attributesOfItem(atPath: url.path)
                    attributes[FileAttributeKey.protectionKey] = FileProtectionType.none
                    try fileManager.setAttributes(attributes, ofItemAtPath: url.path)
                }
                #endif
            }
            write(data: data, to: url)
            
        } catch {
            print("RMLogger File Destination could not write to file \(url).")
        }
    }
    
    private func write(data: Data, to url: URL) {
        let coordinator = NSFileCoordinator(filePresenter: nil)
        var error: NSError?
        coordinator.coordinate(writingItemAt: url, error: &error) { url in
            do {
                let fileHandle = try FileHandle(forWritingTo: url)
                fileHandle.seekToEndOfFile()
                //TODO: check performannce in main queue
                if configuration.maxFileSize > fileHandle.offsetInFile {
                    fileHandle.write(data)
                    fileHandle.synchronizeFile()
                    fileHandle.closeFile()
                } else {
                    fileRolling.rollLogFile(fileHandle: fileHandle, data: data)
                }
                
            } catch {
                print("Could not access RMLogger File Destination could not write to file \(url).")
                return
            }
        }
        
        if let error = error {
            print("Failed writing file with error: \(String(describing: error))")
        }
    }
}
