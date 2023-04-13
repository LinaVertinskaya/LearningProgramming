//
//  TestView.swift
//  LearningProgramming
//
//  Created by Лина Вертинская on 8.03.23.
//

import SwiftUI
import RealmSwift

struct TestView: View {
    @State var isShowMeaning = false

    @ObservedResults(DefinitionItem.self) var definitionItems
    @State var offsetX: CGFloat = 0
    @State var opacity: CGFloat = 1

    @State var definition = DefinitionItem()

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack(spacing: 23) {
                    VStack(alignment: .leading) {
                        Text(definition.mainTerm)
                            .font(.system(size: 36, weight: .black))
                    }
                    ZStack {
                        Text(definition.mainDescription)
                            .font(.system(size: 24, weight: .thin))
                            .opacity(isShowMeaning ? 1 : 0)
                        Button {
                            isShowMeaning.toggle()
                        } label: {
                            Text("Что это?")
                                .padding(.vertical, 13)
                                .padding(.horizontal, 60)
                                .foregroundColor(.white)
                                .background(Color("MainColor"))
                                .cornerRadius(10)
                                .clipShape(Capsule())
                        }
                        .opacity(isShowMeaning ? 0 : 1)
                    }
                }
                .opacity(opacity)
                .offset(x: offsetX)

                Spacer()

                Button {
                    withAnimation {
                        offsetX = -50
                        opacity = 0
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        getRandomDefinition()
                        offsetX = 30
                        isShowMeaning = false

                        withAnimation {
                            offsetX = 0
                            opacity = 1
                        }
                    }
                } label: {
                    HStack {
                        Text("Следующее")
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(Color("MainColor"))
                }

                Rectangle()
                    .frame(height: 28)
                    .opacity(0)
            }
            .frame(maxWidth: .infinity)
            .onAppear {
                getRandomDefinition()
            }
        }
    }

    func getRandomDefinition() {
        let rand = Int.random(in: 0...definitionItems.count - 1)
        self.definition = definitionItems[rand]
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
