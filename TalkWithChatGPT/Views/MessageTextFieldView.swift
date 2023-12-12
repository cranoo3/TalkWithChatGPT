//
//  MessageTextFieldView.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/11.
//

import SwiftUI

struct MessageTextFieldView: View {
    @ObservedObject var viewModel: ContentViewModel
    @FocusState var focus: Bool
    var body: some View {
        HStack {
            // テキストフィールド
            TextField("メッセージ", text: $viewModel.content)
                .focused($focus)
                .frame(height: 30)
                .padding(.horizontal)
                .background() {
                    Color.gray
                        .opacity(0.1)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .onSubmit {
                    if viewModel.fetchDecision() {
                        viewModel.fetchData()
                    }
                }
            
            // メニューを表示する(共有と削除)
            MenuButtonView(viewModel: viewModel)
            
            // 右側の送信ボタン
            Button() {
                focus = false
                viewModel.fetchData()
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
            }
            // 通信中は送信ボタンを押せないようにする
            .disabled(!viewModel.fetchDecision())
        }
        .padding(7)
        .background() {
            Color.white
            Color.indigo
                .opacity(0.2)
        }
        .clipShape(Capsule())
        .shadow(radius: 10)
    }
}

#Preview {
    MessageTextFieldView(viewModel: ContentViewModel())
}
