//
//  MessageView.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/11.
//

import SwiftUI

struct MessageView: View {
    @ObservedObject var viewModel: ContentViewModel
    // ScrollViewを一番下まで移動させるためのID
    @Namespace var bottomId
    
    var body: some View {
        // 送信した文字列を表示
        // ChatGPTからの返信欄
        // フェッチ中はプログレスViewを表示する
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    ForEach(viewModel.messageManager.messages, id: \.self) { message in
                        // 誰から送信されたかで表示されるViewを分ける
                        if message.role == "user" {
                            // 送信したメッセージのロールが"ユーザー"だった場合
                            // 送信したメッセージ
                            SentMessageView(message: message.content)
                            
                        } else if message.role == "assistant" {
                            // 受け取った文字列
                            ReceivedMessageView(viewModel: ContentViewModel(), model: viewModel.gptModel, message: message.content)
                        }
                    }
                    
                    // MARK: ここにサンプルテキストを表示するとデバッグできます
                    
                    // フェッチ中の場合はインジケーターを表示する
                    if viewModel.isFetching {
                        TypingIndicatorView(model: viewModel.gptModel)
                    }
                    
                    // 一番下に表示されている透明なView
                    // TextViewの下の部分に空間を開けるためにも使用しています
                    VStack {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 70)
                            .id(bottomId)
                    }
                }
            }
            .onChange(of: viewModel.messageManager.messages) { _ in
                withAnimation(.spring) {
                    // viewModel.messageManager.messagesの値が変更された時、一番下まで移動する
                    proxy.scrollTo(bottomId)
                }
            }
        }
    }
}

#Preview {
    MessageView(viewModel: ContentViewModel())
}
