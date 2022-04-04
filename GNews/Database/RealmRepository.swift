//
//  RealmRepository.swift
//  GNews
//
//  Created by Aleksey on 03.04.2022.
//

import Foundation
import Unrealm

class RealmRepository {

    // MARK: - Proporties
    static let shared = RealmRepository()
    private let realm: Realm

    // MARK: - Init
    private init() {
        realm = try! Realm()
    }

    // MARK: - Funcs
    func insert(object: Realmable) {
        try! realm.write{
            realm.add(object, update: .modified)
        }
    }
    
    func insert(objects: [Realmable]) {
        for object in objects {
            self.insert(object: object)
        }
    }

    func getAll<T: Realmable>() -> [T] {
        return Array(realm.objects(T.self))
    }

}
