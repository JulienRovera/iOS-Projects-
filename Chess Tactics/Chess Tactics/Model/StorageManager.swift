//
//  StorageManager.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/17/21.
//

import Foundation

class StorageManager{
    var beginnerPuzzleList : [Puzzle]
    var intermediatePuzzleList: [Puzzle]
    var advancedPuzzleList: [Puzzle]
    var userCreatedPuzzleList: [Puzzle]
    var recentPuzzleList: [Puzzle]
    var tryUserCreatedPuzzleList: [Puzzle]?
    var tryRecentPuzzleList: [Puzzle]?
    let intermediateFileName = "intermediate"
    let beginnerFileName = "beginner"
    let advancedFileName = "advanced"
    
    init(){
        let bundle = Bundle.main
        let intermediateUrl = bundle.url(forResource: intermediateFileName, withExtension: ".json")!
        let beginnerUrl = bundle.url(forResource: beginnerFileName, withExtension: ".json")!
        let advancedUrl = bundle.url(forResource: advancedFileName, withExtension: ".json")!
        let decoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: intermediateUrl)
            intermediatePuzzleList = try decoder.decode([Puzzle].self, from: data)
        }catch{
            print(error)
            print("error with intermediate list")
            intermediatePuzzleList = []
        }
        do{
            let beginnerData = try Data(contentsOf: beginnerUrl)
            beginnerPuzzleList = try decoder.decode([Puzzle].self, from: beginnerData)
        }catch{
            print(error)
            print("error with beginner list")
            beginnerPuzzleList = []
        }
        do{
            let advancedData = try Data(contentsOf: advancedUrl)
            advancedPuzzleList = try decoder.decode([Puzzle].self, from: advancedData)
        }catch{
            print(error)
            print("error with advanced list")
            advancedPuzzleList = []
        }
        
        tryUserCreatedPuzzleList = PersistanceManager.shared.load(filePath: "userCreatedPuzzles.plist")
        if tryUserCreatedPuzzleList != nil{
            userCreatedPuzzleList = tryUserCreatedPuzzleList!
        }else{
            userCreatedPuzzleList = []
        }
        tryRecentPuzzleList = PersistanceManager.shared.load(filePath: "recentPuzzles.plist")
        if tryRecentPuzzleList != nil{
            recentPuzzleList = tryRecentPuzzleList!
        }else{
            recentPuzzleList = []
        }
    }
}

class PersistanceManager{
    static let shared = PersistanceManager()
    
    private init() {}
    
    func documentsDirectory()->URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func saveUserCreatedPuzzles(userCreatedPuzzlesList: [Puzzle]){
        let path = documentsDirectory().appendingPathComponent("userCreatedPuzzles.plist")
        let plistEncoder = PropertyListEncoder()
        plistEncoder.outputFormat = .xml
        let encoded = try! plistEncoder.encode(userCreatedPuzzlesList)
        try! encoded.write(to: path)
    }
    
    func saveRecentPuzzles(recentPuzzlesList: [Puzzle]){
        let path = documentsDirectory().appendingPathComponent("recentPuzzles.plist")
        let plistEncoder = PropertyListEncoder()
        plistEncoder.outputFormat = .xml
        let encoded = try! plistEncoder.encode(recentPuzzlesList)
        try! encoded.write(to: path)
    }
    
    func load(filePath: String) -> [Puzzle]?{
        let path = documentsDirectory().appendingPathComponent(filePath)
        let plistDecoder = PropertyListDecoder()
        if let data = try? Data(contentsOf: path){
            let decoded = try! plistDecoder.decode(
                [Puzzle].self, from: data)
            return decoded
        }
        return nil
    }
}
