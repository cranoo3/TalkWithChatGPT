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
                viewModel.colors.gradient
                    .ignoresSafeArea()
                    .opacity(0.1)
                
                // 送ったメッセージ、受け取ったメッセージが表示されるView
                MessageView(viewModel: self.viewModel)
                    .onTapGesture(perform: {
                        // タップされた時にキーボードのフォーカスを外す
                        focus = false
                    })
                
                // 重ねて表示させたいのでVStackとSpacer()で
                VStack {
                    Spacer()
                    
                    // テキストフィールドと送信ボタンのView
                    MessageTextFieldView(viewModel: self.viewModel, focus: self._focus)
                        .padding(.bottom)
                        .padding(.horizontal)
                        // 背景色を透明に見せたい！
                        .background {
                            // 背景のグラデーション
                            LinearGradient(stops: [
                                .init(color: .clear, location: 0.0),
                                .init(color: .white, location: 0.3)
                            ], startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                            
                            LinearGradient(stops: [
                                .init(color: .clear, location: 0.0),
                                .init(color: .indigo, location: 0.3)
                            ], startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                            .opacity(0.1)
                            
                        }
                }
                
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
