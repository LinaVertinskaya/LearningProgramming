//
//  LinksViewModel.swift
//  LearningProgramming
//
//  Created by Лина Вертинская on 9.03.23.
//

import Foundation

class LinksViewModel: ObservableObject {
    @Published var isShowAddLink = false

    @Published var isShowLinkContent = false
    @Published var openUrl = ""
}
