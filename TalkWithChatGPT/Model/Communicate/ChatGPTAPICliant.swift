//
//  APICliant.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/09.
//

import Foundation

struct ChatGPTAPICliant {
    // GetlistValueから各種文字列を受け取る
    let urlString = GetPlistValue.shared.getUrlString()
    let apiKey = GetPlistValue.shared.getApiKey()
    let organizationID = GetPlistValue.shared.getOrganizationID()
    let model = GetPlistValue.shared.getGPTModel()
    
    // String型をURL型に変換する
    var urlResult: Result<URL, Error> {
        if let tmpURL = URL(string: urlString) {
            return .success(tmpURL)
        } else {
            return .failure(CommunicationError.badURL)
        }
    }
    
    // URLを作る関数 -> いい感じのURL
    private func makeURLComponents() throws -> URLComponents {
        // 正しくURLだ -> success(正しいURL)
        switch urlResult {
        case .success(let url):
            // いい感じのURLか確認する
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                // よくない感じのURLだった -> エラー
                throw CommunicationError.cannnotCreateURLComponents
            }
            return components
            
        case .failure(let error):
            throw error
        }
    }
    
    
    /// フェッチする関数
    /// - Parameter messages: ChatGPTResponseのMessageを使用しています。
    /// - Returns: フェッチした結果を返します。正しくフェッチできた場合はJSONからStructへ変換します
    func fetch(messages: [Message]) async -> Result<ChatGPTResponse, Error> {
        do {
            guard let url = try makeURLComponents().url else {
                return .failure(CommunicationError.cannotCreateURL)
            }
            
            // MARK: - httpBodyを作成
            var requestBody: Data? {
                let encodeValue = ChatGPTRequestHttpBody(model: self.model, messages: messages)
                return try? JSONEncoder().encode(encodeValue)
            }
            
            // MARK: - URLリクエストを作成
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.allHTTPHeaderFields = ["Authorization" : "Bearer \(apiKey)"
                                              ,"OpenAI-Organization": organizationID
                                              ,"Content-Type" : "application/json"]
            urlRequest.httpBody = requestBody
            
            guard let (data, urlRequest) = try? await URLSession.shared.data(for: urlRequest) else {
                return .failure(CommunicationError.badURL)
            }
            
            // MARK: - 情報を受け取る
            guard let response = urlRequest as? HTTPURLResponse else {
                return .failure(CommunicationError.responseNotReturned)
            }
            
            guard 200..<300 ~= response.statusCode else {
                return .failure(CommunicationError.badStatusCode(response.statusCode))
            }
            
            // MARK: - 受け取ったJSONをStructに格納する
            let decodeData = try JSONDecoder().decode(ChatGPTResponse.self, from: data)
            return .success(decodeData)
        } catch {
            return .failure(error)
        }
    }
}
