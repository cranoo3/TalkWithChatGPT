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
        ZStack {
            // 背景色の設定
            Color.white
                .ignoresSafeArea()
            
            LinearGradient(colors: [.indigo, .purple], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
                .opacity(0.2)
            
            VStack {
                // タイトルの設定(NavigationTitleの挙動が気に食わなかたので…。)
                Text("Talk With ChatGPT")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical)
                
                Spacer()
                
                MessageView(viewModel: self.viewModel)
                    .onTapGesture(perform: {
                        // タップされた時にキーボードのフォーカスを外す
                        focus = false
                    })
                
                
                // テキストフィールドと送信ボタン
                MessageTextFieldView(viewModel: viewModel, focus: self._focus)
                    .padding(.vertical)
            }
            .padding(.horizontal)
        }
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
