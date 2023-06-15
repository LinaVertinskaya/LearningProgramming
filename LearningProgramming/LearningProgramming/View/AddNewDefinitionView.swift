//
//  AddNewDefinitionView.swift
//  LearningProgramming
//
//  Created by Лина Вертинская on 9.03.23.
//

import SwiftUI
import RealmSwift

struct AddNewDefinitionView: View {

    @State var newDefinition = ""
    @State var newDescription = ""
    @State var showAlert = false
    @ObservedResults(DefinitionItem.self) var definitionItems
    @EnvironmentObject var helperViewModel: HelperViewModel

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Новое определение")
                    .font(.system(size: 20, weight: .black))
                    .padding(.leading, 16)
                Spacer()
                Button {
                    helperViewModel.isShowAddView.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.black)
                }
            }

            VStack(alignment: .leading) {
                HStack {
                    TextField("Термин", text: $newDefinition)
                        .textInputAutocapitalization(.never)
                }
                .padding(.vertical, 13)
                .padding(.horizontal, 23)
                .background(Color("Gray"))
                .cornerRadius(10)

                Text("Значение")
                    .font(.system(size: 14, weight: .black))
                    .padding(.top, 23)
                    .padding(.leading, 23)
                HStack {
                    TextEditor(text: $newDescription)
                        .frame(height: 90)
                        .colorMultiply(Color("Gray"))
                }
                .padding(.vertical, 13)
                .padding(.horizontal, 23)
                .background(Color("Gray"))
                .cornerRadius(10)
            }

            Spacer()

            Button {
                if newDefinition.count == 0 {
                    showAlert.toggle()
                } else {
                    let definition = DefinitionItem()
                    definition.mainTerm = newDefinition
                    definition.mainDescription = newDescription

                    $definitionItems.append(definition)

                    withAnimation {
                        helperViewModel.isShowAddView.toggle()
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

struct AddNewDefinitionView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewDefinitionView()
    }
}
