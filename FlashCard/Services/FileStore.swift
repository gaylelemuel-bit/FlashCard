//
//  FileStore.swift
//  FlashCard
//
//  Created by Lemuel Gayle on 8/11/26.
//

import Foundation

//custom error handler
enum FileStoreError: Error{
    case fileNotFound
}

struct FileStore{
    
    //file name
    private var fileName:String
    
    //assign the file name
    init(fileName: String = "deck.json") {
        self.fileName = fileName
    }
    
    private func fileURL() throws -> URL {
        
        guard let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileStoreError.fileNotFound
        }
        return docs.appendingPathComponent(fileName)
    }
    
    func save<T: Encodable>(_ value: T) throws {
        
        let url = try fileURL()
        
        let data = try JSONEncoder().encode(value)
        
        try data.write(to: url, options: .atomic)
    }
    
    func load<T: Decodable>(_ type: T.Type) throws -> T {
        
        let url = try fileURL()
        
        let data = try Data(contentsOf: url)
        
        return try JSONDecoder().decode(type, from: data)
    }
}
