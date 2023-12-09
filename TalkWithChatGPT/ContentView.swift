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
                    .padding(.top)
                
                Spacer()
                
                
                // 送信した文字列を表示
                // ChatGPTからの返信欄
                // フェッチ中はプログレスViewを表示する
                VStack(alignment: .leading) {
                    Text("You: ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text(viewModel.sentMessage)
                    
                    Divider()
                    
                    Text("ChatGPT: ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    
                    ScrollView {
                        Group {
                            if viewModel.isFetching {
                                VStack {
                                    ProgressView()
                                        .padding()
                                    Text("読み込むまでお待ちください")
                                }
                            } else {
                                Text(viewModel.data.choices.first?.message.content ?? "no message")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                   
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .background() {
                    Color.white
                        .opacity(0.6)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .onTapGesture(perform: {
                    focus = false
                })
                
                // テキストフィールドと送信ボタン
                Group {
                    HStack {
                        TextField("メッセージ", text: $viewModel.content)
                            .focused($focus)
                            .frame(height: 40)
                            .padding(.horizontal)
                            .background() {
                                Color.gray
                                    .opacity(0.1)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .onSubmit {
                                if !(viewModel.isFetching || viewModel.content == "") {
                                    viewModel.fetchData()
                                }
                            }
                        
                        // 右側の送信ボタン
                        Button() {
                            focus = false
                            viewModel.fetchData()
                        } label: {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 40)
                        }
                        // 通信中は送信ボタンを押せないようにする
                        .disabled(viewModel.isFetching || viewModel.content == "")
                    }
                    .padding(10)
                    .background() {
                        Color.white
                        
                        Color.purple
                            .opacity(0.2)
                    }
                    .clipShape(Capsule())
                    .shadow(radius: 10)
                }
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
