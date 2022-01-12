//
//  StorageManager.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation

class StorageManager{
    var tryBookList: [Book]?
    var tryNoteList: [Note]?
    var bookList: [Book]
    var noteList: [Note]
    var readingList: [Book]
    var finishedList: [Book]
    let filename = "books"
    
    init(){
        readingList = []
        finishedList = []
        noteList = []
        tryBookList = PersistanceManager.shared.loadBookList()
        if(tryBookList != nil){
            tryNoteList = PersistanceManager.shared.loadNoteList()
            if(tryNoteList != nil){
                bookList = tryBookList!
                noteList = tryNoteList!
                return
            }
            bookList = tryBookList!
            return
        }
        
        let bundle = Bundle.main
        let url = bundle.url(forResource: filename, withExtension: ".json")!
    
        do{
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            bookList = try decoder.decode([Book].self, from: data)
        }catch{
            print(error)
            bookList = []
        }
    }
}

class PersistanceManager{
    static let shared = PersistanceManager()
    
    func documentsDirectory()->URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func saveBookList(bookList: [Book]){
        let path = documentsDirectory().appendingPathComponent("bookList.plist")
        let plistEncoder = PropertyListEncoder()
        plistEncoder.outputFormat = .xml
        let encoded = try! plistEncoder.encode(bookList)
        try! encoded.write(to: path)
    }
    
    func saveNotes(noteList: [Note]){
        let path = documentsDirectory().appendingPathComponent("noteList.plist")
        let plistEncoder = PropertyListEncoder()
        plistEncoder.outputFormat = .xml
        let encoded = try! plistEncoder.encode(noteList)
        try! encoded.write(to: path)
    }
    
    func loadBookList()-> [Book]?{
        let path = documentsDirectory().appendingPathComponent("bookList.plist")
                let plistDecoder = PropertyListDecoder()
                if let data = try? Data(contentsOf: path){
                    let decoded = try! plistDecoder.decode(
                        [Book].self, from: data)
                    return decoded
                }
                return nil
    }
    
    func loadNoteList()-> [Note]?{
        let path = documentsDirectory().appendingPathComponent("noteList.plist")
                let plistDecoder = PropertyListDecoder()
                if let data = try? Data(contentsOf: path){
                    let decoded = try! plistDecoder.decode(
                        [Note].self, from: data)
                    return decoded
                }
                return nil
    }
}
