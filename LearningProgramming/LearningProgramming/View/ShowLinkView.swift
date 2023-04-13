//
//  ShowLinkView.swift
//  LearningProgramming
//
//  Created by Лина Вертинская on 12.03.23.
//

import SwiftUI

struct ShowLinkView: View {

    @EnvironmentObject var linksViewModel: LinksViewModel

    @State var url: String
    @State var isLoaded = false
    @State var title = ""

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                WebView(url: $url) { isLoad in
                    self.isLoaded = isLoad
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Circle()
                .frame(width: 30)
                .foregroundColor(isLoaded ? Color("MainColor") : .black))
        }
        .onAppear {
            if let url = URL(string: url) {
                self.title = url.host ?? ""
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
