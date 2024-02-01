//
//  RealmMigrator.swift
//  FocusPet
//
//  Created by 刘诚志 on 2024/02/01.
//

import RealmSwift

enum RealmMigrator {
  static private func migrationBlock(migration: Migration, oldSchemaVersion: UInt64) {
    if oldSchemaVersion < 2 {
        migration.enumerateObjects(ofType: TimerData.className()) { _, newObject in
         
        newObject?["coin"] = "200"
      }
    }
  }

  static var configuration: Realm.Configuration {
    Realm.Configuration(schemaVersion: 2, migrationBlock: migrationBlock)
  }
}
