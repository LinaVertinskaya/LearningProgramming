//
//  AddNewLinkView.swift
//  LearningProgramming
//
//  Created by Лина Вертинская on 9.03.23.
//

import SwiftUI
import RealmSwift

struct AddNewLinkView: View {

    @State var linkTitle = ""
    @State var link = ""
    @EnvironmentObject var linksViewModel: LinksViewModel
    @State var showAlert = false

    @ObservedResults(LinksItem.self) var links

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Новая ссылка")
                    .font(.system(size: 20, weight: .black))
                    .padding(.leading, 16)
                Spacer()
                Button {
                    linksViewModel.isShowAddLink.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.black)
                }
            }

            VStack(alignment: .leading) {
                HStack {
                    TextField("Название", text: $linkTitle)
                }
                .padding(.vertical, 13)
                .padding(.horizontal, 23)
                .background(Color("Gray"))
                .cornerRadius(10)

                HStack {
                    TextField("Ссылка", text: $link)
                }
                .padding(.vertical, 13)
                .padding(.horizontal, 23)
                .background(Color("Gray"))
                .cornerRadius(10)
            }

            Spacer()

            Button {
                if linkTitle.count < 0,
                   link.count < 0 {
                    showAlert.toggle()
                } else {
                    let newLink = LinksItem()
                    newLink.link = link
                    newLink.linkName = linkTitle

                    $links.append(newLink)

                    withAnimation {
                        linksViewModel.isShowAddLink.toggle()
                    }
                }
            } label: {
                Text("Сохранить")
                    .padding(.vertical, 13)
                    .frame(maxWidth: .infinity)
                    .background(Color("MainColor"))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .alert(Text("Поля не заполнены"), isPresented: $showAlert, actions: {})
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(15)
        .background(.white)
    }
}

struct AddNewLinkView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewLinkView()
    }
}
