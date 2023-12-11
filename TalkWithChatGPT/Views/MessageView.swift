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
                .padding(.bottom)
            Text(viewModel.sentMessage)
            
            Divider()
            
            HStack {
                Text("ChatGPT: ")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical)
                
                Text(viewModel.gptModel)
                    .textCase(.uppercase)
                    .font(.title2)
                    .foregroundStyle(Color.gray)
            }
            
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
                        Text(viewModel.fromChatGPT.getAttributedString())
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
