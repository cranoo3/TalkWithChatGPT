//
//  CommunicationError.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/09.
//

import Foundation

enum CommunicationError: Error {
    case badURL
    case cannnotCreateURLComponents
    case cannotCreateURL
    case responseNotReturned
    case badStatusCode(Int)
    case fetchError
    
    var message: String {
        switch self {
        case .badURL:
            return "無効なURLです"
        case .cannnotCreateURLComponents:
            return "コンポーネントが作成できませんでした"
        case .cannotCreateURL:
            return "URLが作成できませんでした"
        case .responseNotReturned:
            return "通信ができませんでした"
        case .badStatusCode(let statusCode):
            return "通信ができませんでした\(statusCode)"
        case .fetchError:
            return "解析できませんでした"
        }
    }
}
