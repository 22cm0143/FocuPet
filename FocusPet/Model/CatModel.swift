//
//  CatModel.swift
//  FocusPet
//
//  Created by 刘诚志 on 2024/01/18.
//

import Foundation
import RealmSwift

class CatModel: ObservableObject {
    
    @Published var cats: [Cat]
    
    @Published var isBuyAlert = false
    @Published var isSelectAlert = false
    @Published var isCancelAlert = false
    
    
    private var realm: Realm

       init() {
           realm = try! Realm()
           cats = Array(realm.objects(Cat.self))
       }
}

class Cat: Object,ObjectKeyIdentifiable{
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var price: Int
    @Persisted var catname: String
    @Persisted var catimage: String
    @Persisted var isBought: Bool
    @Persisted var isSelected: Bool

    convenience init( price: Int, catname: String, catimage: String, isBought: Bool, isSelected: Bool) {
        self.init()
        self.price = price
        self.catname = catname
        self.catimage = catimage
        self.isBought = isBought
        self.isSelected = isSelected
    }
}
