//
//  SetMessage.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/13.
//

import Foundation

/// ChatGPTに送信するメッセージ、受け取ったメッセージを管理するクラス
class MessageManager: Codable, Identifiable {
    /// メッセージの履歴が入ります
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
    
    // MARK: - setUserMessage
    /// 受け取ったメッセージを追加します
    /// この関数はデータをフェッチする時に使用しています
    func setAssistantMessage(message: Message) {
        messages.append(message)
    }
}
