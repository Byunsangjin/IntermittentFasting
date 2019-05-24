//
//  DBManager+Weight.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 15/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import Foundation

extension DBManager {
    // Select
    func selectWeightDB() -> Array<ModelWeight> {
        print("selectWeightDB")
        
        var weightArray = Array<ModelWeight>()
        let dbWeightArray = self.database.objects(ModelWeight.self)
        
        for dbWeight in dbWeightArray {
            weightArray.append(dbWeight)
        }
        
        return weightArray
    }
    
    
    // Insert
    func insertWeightDB(weight: ModelWeight) {
        try! self.database.write {
            self.database.add(weight, update: true)

            print("Insert WeightDB")
        }
    }
    
    
    
}
