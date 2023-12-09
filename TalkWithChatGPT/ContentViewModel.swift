//
//  ContentViewModel.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/08.
//

import Foundation

class ContentViewModel: ObservableObject {
    /// ChatGPTから帰ってきたデータが入っています
    @Published var data: ChatGPTResponse
    /// エラーが発生した場合にアラートを表示させるためのフラグです
    @Published var isShowErrorAlert: Bool
    /// フェッチ中はtrueになる
    @Published var isFetching: Bool
    /// エラーメッセージが入る
    @Published var errorMessage: String?
    /// ChatGPTへ送る文字列
    @Published var content: String
    /// 送った文字列(表示用)
    @Published var sentMessage: String
    
    let client = ChatGPTAPICliant()
    var message: [String]
    
    init() {
        data = ChatGPTResponse(id: "", object: "", created: 0, model: "",
                               choices: [
                                Choice(index: 0, message: Message(role: "", content: "ここに表示されます"),finishReason: "")
                               ],
                               usage: Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0),
                               systemFingerprint: JSONNull())
        isShowErrorAlert = false
        isFetching = false
        content = ""
        sentMessage = ""
        message = []
    }
    
    func setUserMessage(content: String) {
        message.append("""
{"role": "user", "content": "\(content)"}
"""
)
    }
    
    func setAssistantMessage(content: String) {
        message.append("""
{"role": "assistant", "content": "\(content)"}
"""
)
    }
    
    @MainActor
    func fetchData() {
        Task {
            // フェッチ中のフラグ
            isFetching = true
            // Viewに表示するためにsentMessageへ代入する
            sentMessage = content
            // メッセージをセットする
            setUserMessage(content: self.content)
            content = ""
            
            let result = await client.fetch(message: self.message)
            
            
            // 戻ってきた結果が良ければ情報を入れる
            switch result {
            case .success(let data):
                self.data = data
                // 会話の履歴を追加する
                setAssistantMessage(content: data.choices.first?.message.content ?? "no message")
                
            case .failure(let error):
                isShowErrorAlert = true
                if let error = error as? CommunicationError {
                    errorMessage = error.message
                } else {
                    errorMessage = error.localizedDescription
                }
            }
            // ロード終了
            isFetching = false
        }
    }
}
