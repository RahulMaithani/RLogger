//
//  RFileRolling.swift
//  RLogger
//
//  Created by Rahul Maithani on 04/04/21.
//

import Foundation

struct RFileRolling {
    
    let configuration: RLoggerConfiguration
    
    init(configuration: RLoggerConfiguration) {
        self.configuration = configuration
    }
    
    
    func rollLogFile(fileHandle: FileHandle, data: Data) {
        
        print("Rolling file")
        // CLOSING FILE
        fileHandle.synchronizeFile()
        
        fileHandle.closeFile()
        
        archiveFile()
        removeOlderFile()
        
        //remove content of file
        removeContentOfMainLogFile(fileHandle: fileHandle, data: data)
    }
    
    // Will copy RMLogger.log.txt into new file and remove content of RMLogger.log.txt file, if file(RMLogger.log) size reach to max file size
    private func archiveFile() {
        
        let fileManager = FileManager.default
        
        do {
            
            let fileName = "RMLogger.log"
            let DocumentDirURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let logFileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
            print("Renaming file.")
            try fileManager.copyItem(atPath: logFileURL.path , toPath: archiveFileName(text: logFileURL.path ) )
            
        } catch let error {
            print("Error while renaming file name: \(error.localizedDescription)")
        }
    }
    
    private func archiveFileName(text: String)-> String {
        
        let url = text.replacingOccurrences(of: "RMLogger.log.txt", with: "RMLogger_\(Date().timeIntervalSince1970).log.txt")
        return url
    }
    
    // Will remove oldest file, if number of files reach to max number of files
    private func removeOlderFile() {
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            var files = fileURLs.map { $0.path }
            files = files.filter { $0.contains(".log.txt") && !$0.contains("RMLogger.log.txt")  }
            if configuration.maxNumberOfFiles <= files.count {
                files = files.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                
                do {
                    print("Removing files \(files.first ?? "")")
                    try fileManager.removeItem(atPath: files.first ?? "")
                } catch {
                    print("Error while removing files \(files.first ?? ""): \(error.localizedDescription)")
                }
            }
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
    
    // Will clear content of main log file(RMLogger.log.txt)
    private func removeContentOfMainLogFile(fileHandle: FileHandle, data: Data) {
        
        guard let url = configuration.logFileURL else { return }
        let log = String(bytes: data, encoding: .utf8) ?? ""
        do {
            print("Removing content of main log file(RMLogger.log.txt)")
            try log.write(to: url, atomically: true, encoding: .utf8)
            fileHandle.synchronizeFile()
            fileHandle.closeFile()
        } catch let error {
            print("Failed to remove content of main log file(RMLogger.log.txt): \(error.localizedDescription)")
        }
    }
}
