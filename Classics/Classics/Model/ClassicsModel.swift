//
//  ClassicsModel.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation

struct ClassicsModel{
    let manager: StorageManager
    var bookList : [Book]
    var readingList : [Book]
    var finishedList : [Book]
    var noteList: [Note]
    init(){
        manager = StorageManager()
        bookList = manager.bookList
        readingList = manager.readingList
        finishedList = manager.finishedList
        noteList = manager.noteList
    }
    
}
