//
//  LinksView.swift
//  LearningProgramming
//
//  Created by Лина Вертинская on 9.03.23.
//

import SwiftUI
import RealmSwift

struct LinksView: View {

    @EnvironmentObject var linksViewModel: LinksViewModel

    @ObservedResults(LinksItem.self) var links

    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                ScrollView() {
                    VStack(spacing: 10) {
                        ForEach(links, id: \.id) { link in
                            NavigationLink {
                                ShowLinkView(url: link.link)
                            } label: {
                                LinkItem(link: link) { _ in
                                    $links.remove(link)
                                }
                                .foregroundColor(.black)
                            }
                        }
                    }
                }
                .navigationTitle("Ссылки")
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, alignment: .leading)

                Button {
                    linksViewModel.isShowAddLink.toggle()
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 56, height: 56)
                            .foregroundColor(Color("MainColor"))
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                }
                .offset(x: -20, y: -30)
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct LinkItem: View {

    var link: LinksItem
    var onDelete: (Bool) -> ()

    @EnvironmentObject var linksViewModel: LinksViewModel

    var body: some View {
        HStack {
            HStack(spacing: 15) {
                Image(systemName: "link")
                Text(link.linkName)
                    .font(.system(size: 14))
            }

            Spacer()

            Button {
                onDelete(true)
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color("Gray"))
        .cornerRadius(10)
    }
}

struct LinksView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
