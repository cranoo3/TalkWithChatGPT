//
//  SetMessage.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/13.
//

import Foundation

class SetChatGPTMessages {
    /// ChatGPTに送信するhttpBodyの構造体encodeして使用する
    var chatGPTRequestMessage: [ChatGPTMessage] = []
    
    // MARK: - setUserMessage
    /// ユーザー が送信したメッセージの内容を追加します。
    /// この関数はデータをフェッチする時に使用しています
    /// messageにユーザーが入力された文字が入る。encodeして使用
    func setUserMessage(content: String) {
        chatGPTRequestMessage.append(ChatGPTMessage(role: "user", content: "\(content)"))
        print("setUser: \(chatGPTRequestMessage)")
    }
    
    // MARK: - setAssistantMessage
    /// ChatGPTから戻ってきたデータをcontentに追加する関数
    /// この関数は正しい形式でデータが戻ってきた時に実行されます
    /// messageにChatGPTから戻ってきた文字が入ります。encodeして使用
    func setAssistantMessage(content: String) {
        chatGPTRequestMessage.append(ChatGPTMessage(role: "assistant", content: "\(content)"))
        print("setAssistant: \(chatGPTRequestMessage)")
    }
}
