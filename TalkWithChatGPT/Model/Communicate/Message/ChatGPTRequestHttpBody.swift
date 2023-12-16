//
//  ChatGPTMessageManager.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/11.
//

import Foundation

/// メッセージをHTTPBodyに変換するための構造体です
/// ChatGPTAPICliantで使用しています
struct ChatGPTRequestHttpBody: Codable {
    let model: String
    let messages: [Message]
}
