//
//  ContentView.swift
//  LearningProgramming
//
//  Created by Лина Вертинская on 7.03.23.
//

import SwiftUI

struct ContentView: View {

    @State var selected = 1
    
    @ObservedObject var helperViewModel = HelperViewModel()
    @ObservedObject var linksViewModel = LinksViewModel()

    init() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }

    var body: some View {

        ZStack {
            TabView(selection: $selected) {
                HelperView()
                    .environmentObject(helperViewModel)
                    .tag(1)
                    .tabItem {
                        VStack {
                            Image(systemName: "list.star")
                            Text("Мой помощник")
                        }
                    }
                TestView()
                    .padding(.horizontal, 15)
                    .tag(2)
                    .tabItem {
                        VStack {
                            Image(systemName: "text.badge.checkmark")
                            Text("Проверка")
                        }
                    }
                LinksView()
                    .environmentObject(linksViewModel)
                    .tag(3)
                    .tabItem {
                        VStack {
                            Image(systemName: "link")
                            Text("Полезные ссылки")
                        }
                    }
            }

            if helperViewModel.isShowAddView {
                AddNewDefinitionView()
                    .environmentObject(helperViewModel)
            }

            if linksViewModel.isShowAddLink {
                AddNewLinkView()
                    .environmentObject(linksViewModel)
            }

//            if linksViewModel.isShowLinkContent {
//                ShowLinkView(url: $linksViewModel.openUrl)
//                    .environmentObject(linksViewModel)
//            }

//            VStack {
//
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
