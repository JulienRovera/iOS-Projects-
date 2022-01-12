//
//  StorageManager.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/3/21.
//

import Foundation

class StorageManager{
    var buildingList: [Building]
    var tryBuildingList: [Building]?
    let filename = "buildings"
    
    init(){
        tryBuildingList = PersistanceManager.shared.load()
        if(tryBuildingList != nil){
            buildingList = tryBuildingList!
            return
        }
        let bundle = Bundle.main
        let url = bundle.url(forResource: filename, withExtension: ".json")!
        
        do{
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            buildingList = try decoder.decode([Building].self, from: data)
        } catch{
            print(error)
            buildingList = []
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
    
    func save(buildingList: [Building]){
        let path = documentsDirectory().appendingPathComponent("buildingList.plist")
        let plistEncoder = PropertyListEncoder()
        plistEncoder.outputFormat = .xml
        let encoded = try! plistEncoder.encode(buildingList)
        try! encoded.write(to: path)
    }
    
    func load() -> [Building]?{
        let path = documentsDirectory().appendingPathComponent("buildingList.plist")
        let plistDecoder = PropertyListDecoder()
        if let data = try? Data(contentsOf: path){
            let decoded = try! plistDecoder.decode(
                [Building].self, from: data)
            return decoded
        }
        return nil
    }
}
