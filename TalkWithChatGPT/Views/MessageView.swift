//
//  MessageView.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/11.
//

import SwiftUI

struct MessageView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    
    var body: some View {
        // 送信した文字列を表示
        // ChatGPTからの返信欄
        // フェッチ中はプログレスViewを表示する
        VStack(alignment: .leading) {
            Text("You: ")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            
            Text(viewModel.sentMessage)
                .frame(minHeight: 20)
            
            Divider()
            
            HStack {
                Text("ChatGPT: ")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(viewModel.gptModel)
                    .textCase(.uppercase)
                    .font(.title2)
                    .foregroundStyle(Color.gray)
            }
            .padding(.top, 5)
            
            // ChatGPTからの返答を表示する
            ScrollView {
                Group {
                    if viewModel.isFetching {
                        // ロード中のグルグル回るやつ
                        VStack {
                            ProgressView()
                                .padding()
                            Text("読み込むまでお待ちください")
                        }
                    } else {
                        Text(viewModel.receivedMessage)
                            .frame(minHeight: 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .shadow(radius: 10)
        
    }
}

#Preview {
    MessageView(viewModel: ContentViewModel())
}
