//
//  ContentView.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/07.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @FocusState var focus: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 背景色の設定
                Color.white
                    .ignoresSafeArea()
                
                // 背景のグラデーション
                LinearGradient(colors: [.indigo, .purple], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                    .opacity(0.15)
                
                VStack {
                    // 送ったメッセージ、受け取ったメッセージが表示されるView
                    MessageView(viewModel: self.viewModel)
                        .onTapGesture(perform: {
                            // タップされた時にキーボードのフォーカスを外す
                            focus = false
                        })
                    
                    // テキストフィールドと送信ボタンのView
                    MessageTextFieldView(viewModel: viewModel, focus: self._focus)
                        .padding(.vertical)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Talk With ChatGPT")
        }
        // エラーが発生した時のアラート
        .alert("エラーが発生しました", isPresented: $viewModel.isShowErrorAlert) {
            Button(role: .cancel) {
                // 何もしないので処理はなし
            } label: {
                Text("何もしない")
            }
            Button {
                exit(-1)
            } label: {
                Text("アプリを終了する")
            }
            
        } message: {
            Text(viewModel.errorMessage ?? "エラーです")
        }
    }
}

#Preview {
    ContentView()
}
