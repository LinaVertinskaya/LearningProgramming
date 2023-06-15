//
//  DefinitionItem.swift
//  LearningProgramming
//
//  Created by Лина Вертинская on 11.03.23.
//

import Foundation
import RealmSwift

class DefinitionItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var mainTerm: String = ""
    @Persisted var mainDescription: String = ""
    @Persisted var weight: Int = 0

    override class func primaryKey() -> String? {
        "id"
    }
}
