//
//  ChatGPTMessageManager.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/11.
//

import Foundation


struct ChatGPTRequestHttpBody: Codable {
    let model: String
    let messages: [ChatGPTMessage]
}

struct ChatGPTMessage: Codable {
    let role, content: String
}
