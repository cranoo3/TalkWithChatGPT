//
//  SetMessage.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/13.
//

import Foundation

class SetChatGPTMessages: Codable {
    var messages: [Message]
    
    init () {
        messages = []
    }
    
    // MARK: - setUserMessage
    /// ユーザー が送信したメッセージの内容を追加します。
    /// この関数はデータをフェッチする時に使用しています
    /// messageにユーザーが入力された文字が入る。encodeして使用
    func setUserMessage(content: String) {
        messages.append(Message(role: "user", content: "\(content)"))
    }
}
