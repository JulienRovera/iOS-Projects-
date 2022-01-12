//
//  ClassicsManager.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation

class ClassicsManager: ObservableObject{
    @Published var classicsModel = ClassicsModel()
    @Published var mainViewState: MainViewState
    @Published var bookFilter: BookFilter
    @Published var notesList: [Note]
    let formatter : DateFormatter
    var filteredList: [Book] {switch bookFilter{
    case .all: return classicsModel.bookList
    case .finished: return classicsModel.finishedList
    case .reading: return classicsModel.readingList
    }}
    var filterPredicate: NSPredicate? {switch bookFilter{
    case .all: return nil
    case .reading: return NSPredicate(format: "reading = true")
    case .finished: return NSPredicate(format: "finished = true")
    }}
    init(){
        let tempClassicsModel = ClassicsModel()
        mainViewState = .rowView
        bookFilter = .all
        notesList = tempClassicsModel.noteList
        formatter = DateFormatter()
        formatter.dateStyle = .long
        initLists()
    }
    
    enum MainViewState{
        case rowView, cardView
    }
    
    enum BookFilter{
        case all, reading, finished
    }
    
    func markAsReading(index: Int){
        if(classicsModel.bookList[index].reading == false){
            classicsModel.bookList[index].reading = true
            classicsModel.readingList.append(classicsModel.bookList[index])
        }
        else{
            classicsModel.bookList[index].reading = false
            let readingIndex = classicsModel.readingList.firstIndex(of: classicsModel.bookList[index])
            classicsModel.readingList.remove(at: readingIndex!)
        }
    }
    
    func getTrueIndex(index: Int)->Int{
        return classicsModel.bookList.firstIndex(of: filteredList[index])!
    }
    
    func updatePageNumber(index: Int, pageNumber: Int){
        classicsModel.bookList[index].currentPage = pageNumber
        if(pageNumber == classicsModel.bookList[index].pages){
            classicsModel.bookList[index].finished = true
            classicsModel.finishedList.append(classicsModel.bookList[index])
            markAsReading(index: index)
        }
    }
    
    func updatePageNumberMO(book: BookMO, pageNumber: Int){
        book.currentPage = Int64(pageNumber)
        if(pageNumber == book.pages){
            book.finished = true
            book.reading = false
        }
    }
    
    func getPagesRemainingText(index: Int) -> String{
        if(classicsModel.bookList[index].finished){
            return "You've finished this book!"
        }
        if(classicsModel.bookList[index].reading == false){
            return "You currently aren't reading this book"
        }
        return "You are curretnly on page " + String(classicsModel.bookList[index].currentPage)
    }
    
    func getPagesRemainingTextMO(book: BookMO) -> String{
        if(book.finished){
            return "You've finished this book!"
        }
        if(book.reading == false){
            return "You currently aren't reading this book"
        }
        return "You are curretnly on page " + String(book.currentPage)
    }
    
    func createNote(index: Int, content: String){
        print(content)
        let newNote = Note(progress: classicsModel.bookList[index].currentPage, date: Date(), content: content, book: classicsModel.bookList[index].title)
        notesList.insert(newNote, at: 0)
    }
    
    func deleteNote(note: Note){
        let index = notesList.firstIndex(where:{note.id == $0.id})!
        notesList.remove(at: index)
    }
    
    func editNote(note: Note, content: String){
        let index = notesList.firstIndex(where:{note.id == $0.id})!
        notesList[index].content = content
    }
    
    func initLists(){
        for book in classicsModel.bookList{
            if(book.reading){
                classicsModel.readingList.append(book)
            }
            if(book.finished){
                classicsModel.finishedList.append(book)
            }
        }
    }
}
