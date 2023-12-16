//
//  ContentViewModel.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/08.
//

import Foundation

class ContentViewModel: ObservableObject {
    /// APICliant
    let client = ChatGPTAPICliant()
    /// ChatGPTから帰ってきたデータが入っています
    var data: ChatGPTResponse
    /// ChatGPTへ送るメッセージを設定するクラス
    var chatMessages = SetChatGPTMessages()
    /// エラーが発生した場合にアラートを表示させるためのフラグです
    @Published var isShowErrorAlert: Bool
    /// データを削除する時に表示するアラートです
    @Published var isShowDeleteAlert: Bool
    /// フェッチ中はtrueになるフラグ。ProgressViewの制御に使用
    @Published var isFetching: Bool
    /// エラーメッセージが入る
    @Published var errorMessage: String?
    /// ChatGPTへ送る文字列
    @Published var content: String
    /// ユーザーが送った文字列 (表示用)
    @Published var sentMessage: String
    /// ChatGPTからの返答 (表示用)
    @Published var receivedMessage: String
    /// GPTモデルの名前?バージョンが入る場所です。(表示用)
    @Published var gptModel: String
    
    // 初期化処理
    init() {
        data = ChatGPTResponse(id: "", object: "", created: 0, model: "",
                               choices: [
                                Choice(index: 0, message: Message(role: "", content: "未取得"),finishReason: "")
                               ],
                               usage: Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0),
                               systemFingerprint: JSONNull())
        isShowErrorAlert = false
        isShowDeleteAlert = false
        isFetching = false
        content = ""
        sentMessage = ""
        receivedMessage = ""
        gptModel = GetPlistValue.shared.getGPTModel()
        
    }
    
    // MARK: - shareData()
    /// 今までの会話データを共有します
    /// - Returns: convertDataでStringに正しく変換できた場合、データを返します
    /// 帰ってきたデータを共有します
    func shareData() -> String {
        /// 会話データをJSONからStringへ変換します
        let convertData = { () -> Result<String, Error> in
            // 構造体をStringへ変換
            let encodeValue = self.chatMessages.messages
            guard let shareValue = try? JSONEncoder().encode(encodeValue) else {
                return .failure(CommunicationError.fetchError)
            }
            
            guard let encodeString = String(data: shareValue, encoding: .utf8) else {
                return .failure(CommunicationError.fetchError)
            }
            
            return .success(encodeString)
        }
        
        switch convertData() {
        case .success(let data):
            return data
        case .failure(let error):
            isShowErrorAlert = true
            if let error = error as? CommunicationError {
                errorMessage = error.message
            } else {
                errorMessage = error.localizedDescription
            }
            return ""
        }
    }
    
    /// データを削除します
    func deleteData() {
        // 取得データの削除
        data = ChatGPTResponse(id: "", object: "", created: 0, model: "",
                               choices: [
                                Choice(index: 0, message: Message(role: "", content: "未取得"),finishReason: "")
                               ],
                               usage: Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0),
                               systemFingerprint: JSONNull())
        
        // 会話の履歴の削除
        chatMessages.messages.removeAll()
        
        // 表示されている文字を削除
        content = ""
        sentMessage = ""
        receivedMessage = ""
    }
    
    /// fetchが行えるか判定する
    func fetchDecision() -> Bool {
        // フェッチ中でもなくユーザーの入力が空でもない場合に行えるようにする
        if !(isFetching || content == "") {
            return true
        }
        return false
    }
    
    @MainActor
    func fetchData() {
        Task {
            // フェッチ中のフラグを立てる
            isFetching = true
            // ユーザが入力したメッセージを記録する
            chatMessages.setUserMessage(content: self.content)
            // ユーザが入力したメッセージを表示する
            sentMessage = content
            // ユーザが入力したTextFieldの文字を空にする
            content.removeAll()
            
            // データ取得
            let result = await client.fetch(messages: chatMessages.messages)
            
            // 戻ってきた結果が良ければ情報を入れる
            switch result {
            case .success(let data):
                self.data = data
            case .failure(let error):
                isShowErrorAlert = true
                if let error = error as? CommunicationError {
                    errorMessage = error.message
                } else {
                    errorMessage = error.localizedDescription
                }
            }
            
            // 会話をMessageの配列に追加
            chatMessages.messages.append(data.choices.first?.message ?? Message(role: "", content: ""))
            receivedMessage = data.choices.first?.message.content ?? "No Message"
            
            // ロード終了
            isFetching = false
        }
    }
}
