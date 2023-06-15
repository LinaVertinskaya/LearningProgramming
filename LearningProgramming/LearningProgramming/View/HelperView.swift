//
//  HelperView.swift
//  LearningProgramming
//
//  Created by Лина Вертинская on 7.03.23.
//

import SwiftUI
import RealmSwift

struct HelperView: View {

    @State var searchText = ""
    @EnvironmentObject var helperViewModel: HelperViewModel
    @ObservedResults(DefinitionItem.self, sortDescriptor: SortDescriptor(keyPath: "mainTerm", ascending: true)) var definitionItems

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 25) {
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 15, height: 15)
                        TextField("Поиск", text: $searchText)
                            .textInputAutocapitalization(.never)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .background(Color("Gray"))
                    .cornerRadius(10)
                    .searchable(text: $searchText, collection: $definitionItems, keyPath: \.mainTerm)

                    VStack(spacing: 20) {
                        ForEach(definitionItems, id: \.id) { item in
                            HelperItem(helperItem: item) {
                                withAnimation {
                                    $definitionItems.remove(item)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 15)
            }

            Button {
                helperViewModel.isShowAddView.toggle()
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
}

struct HelperItem: View {

    @State var offsetX: CGFloat = 0
    var helperItem: DefinitionItem
    var onDelete: () -> ()

    var body: some View {
        ZStack(alignment: .trailing) {

            removeImage()

            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(helperItem.mainTerm)
                        .font(.system(size: 18, weight: .black))
                }

                Divider()

                VStack(alignment: .leading) {
                    Text(helperItem.mainDescription)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(Color("LightPurple"))
            .cornerRadius(10)
            .offset(x: offsetX)
            .gesture(DragGesture()
                .onChanged { value in
                    if value.translation.width < 0 {
                        offsetX = value.translation.width
                    }
                }
                .onEnded { value in
                    withAnimation {
                        if screenSize().width * 0.7 < -value.translation.width {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            withAnimation {
                                offsetX = -screenSize().width
                                onDelete()
                            }
                        } else {
                            offsetX = .zero
                        }
                    }
                }
            )
        }
    }

    @ViewBuilder
    func removeImage() -> some View {
        Image(systemName: "xmark")
            .resizable()
            .frame(width: 10, height: 10)
            .offset(x: 30)
            .offset(x: offsetX * 0.5)
            .scaleEffect(CGSize(width: 0.1 * -offsetX * 0.08,
                                height: 0.1 * -offsetX * 0.08))
    }
}

struct HelperView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func screenSize() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
}
