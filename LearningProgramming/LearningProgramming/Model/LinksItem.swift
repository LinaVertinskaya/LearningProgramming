//
//  LinksItem.swift
//  LearningProgramming
//
//  Created by Лина Вертинская on 13.03.23.
//

import Foundation
import RealmSwift

class LinksItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var linkName: String = ""
    @Persisted var link: String = ""

    override class func primaryKey() -> String? {
        "id"
    }
}
