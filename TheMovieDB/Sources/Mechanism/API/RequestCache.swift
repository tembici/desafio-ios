//
//  RequestCache.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

class RequestCache {
    private var cachePath: URL?
    private let identifier: String
    
    init(timeLimit: TimeInterval = 604800, itemsLimit: Int = 1000, sizeLimit: Int = 0, identifier: String = "Generic") {
        let fileManager = FileManager.default
        
        do {
            let subDirectory: String = "\(Bundle.main.bundleIdentifier?.capitalized ?? "API")/Caches/\(identifier)/"
            if let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first?
                .appendingPathComponent(subDirectory) {
                
                try fileManager.createDirectory(at: cachePath, withIntermediateDirectories: true, attributes: nil)
                self.cachePath = cachePath
            }
        } catch {
            #if DEBUG
            print("\n----------------------------------\nCould not create the cache folder\n----------------------------------\n")
            #endif
        }
        
        self.identifier = identifier
        self.removeExpiredFiles(timeLimit: timeLimit, itemsLimit: itemsLimit, sizeLimit: sizeLimit)
    }
    
    subscript(name: String) -> Data? {
        get {
            if let path = pathFrom(name: name) {
                return try? Data(contentsOf: path)
            }
            return nil
        }
        set(newValue) {
            if let newValue = newValue, let path = pathFrom(name: name) {
                try? newValue.write(to: path, options: .atomic)
            }
        }
    }
    
    func removeAllFiles() {
        for file in cachedFiles() {
            #if DEBUG
            print("\n----------------------------------\nCache deleted: \(file.path)\n----------------------------------\n")
            #endif
            
            try? FileManager.default.removeItem(at: file.path)
        }
    }
    
    private func pathFrom(name: String) -> URL? {
        if let sha1 = SHA1.from(string: name) {
            return cachePath?.appendingPathComponent("\(sha1).tmp")
        }
        return nil
    }
    
    private func removeExpiredFiles(timeLimit: TimeInterval, itemsLimit: Int, sizeLimit: Int) {
        let expireDate = Date(timeIntervalSinceNow: -timeLimit)

        var size = 0
        var items = 0

        for file in cachedFiles() {
            if items >= itemsLimit || (sizeLimit > 0 && size >= sizeLimit) || file.accessDate == nil || file.accessDate! < expireDate {
                #if DEBUG
                print("\n----------------------------------\nCache deleted: \(file.path)\n----------------------------------\n")
                #endif

                try? FileManager.default.removeItem(at: file.path)
                continue
            }

            size += file.fileSize ?? 0
            items += 1
        }

        #if DEBUG
        let fileSize = ByteCountFormatter.string(fromByteCount: Int64(size), countStyle: .file)
        print("\n----------------------------------\nCache identifier: \(identifier)\nSize: \(fileSize)\nItems: \(items)\n----------------------------------\n")
        #endif
    }
    
    private func cachedFiles() -> [(path: URL, accessDate: Date?, fileSize: Int?)] {
        let fileManager = FileManager.default
        let keys: Set<URLResourceKey> = [.isDirectoryKey, .contentAccessDateKey, .totalFileAllocatedSizeKey]
        
        var files = [(path: URL, accessDate: Date?, fileSize: Int?)]()
        
        if let cachePath = cachePath, let paths = try? fileManager.contentsOfDirectory(at: cachePath, includingPropertiesForKeys: Array(keys), options: .skipsHiddenFiles) {
            files.reserveCapacity(paths.count)
            
            for path in paths {
                guard let values = try? path.resourceValues(forKeys: keys), values.isDirectory == false else {
                    continue
                }
                
                files.append((path: path, accessDate: values.contentAccessDate, fileSize: values.totalFileAllocatedSize))
            }
            
            files.sort { file1, file2 in
                if let date1 = file1.accessDate, let date2 = file2.accessDate {
                    return date1.compare(date2) == .orderedDescending
                }
                
                return true
            }
        }
        
        return files
    }
    
}
