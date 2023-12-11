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
    /// ユーザーが送った文字列(表示用)
    @Published var sentMessage: String
    /// ChatGPTから送られてきた文字列
    @Published var fromChatGPT: String
    /// GPTモデルの名前?バージョンが入る場所です。(表示用)
    @Published var gptModel: String
    /// ChatGPTに送信するhttpBodyの構造体encodeして使用する
    var chatGPTRequestMessage: [ChatGPTMessage]
    
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
        sentMessage = " "
        fromChatGPT = ""
        gptModel = GetPlistValue.shared.getGPTModel()
        chatGPTRequestMessage = []
    }
    
    /// ユーザー が送信したメッセージの内容を追加します。
    /// この関数はデータをフェッチする時に使用しています
    /// messageにユーザーが入力された文字が入る。encodeして使用
    func setUserMessage(content: String) {
        chatGPTRequestMessage.append(ChatGPTMessage(role: "user", content: "\(content)"))
        print("setUser: \(chatGPTRequestMessage)")
    }
    
    /// ChatGPTから戻ってきたデータをcontentに追加する関数
    /// この関数は正しい形式でデータが戻ってきた時に実行されます
    /// messageにChatGPTから戻ってきた文字が入ります。encodeして使用
    private func setAssistantMessage(content: String) {
        chatGPTRequestMessage.append(ChatGPTMessage(role: "assistant", content: "\(content)"))
        print("setAssistant: \(chatGPTRequestMessage)")
    }
    
    /// fetchが行えるか判定する
    ///
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
            // フェッチ中のフラグ
            isFetching = true
            // Viewに表示するためにsentMessageへ代入する
            sentMessage = content
            // メッセージをセットする
            setUserMessage(content: self.content)
            // TextFieldの文字を空にする
            content.removeAll()
            
            let result = await client.fetch(message: chatGPTRequestMessage)
            
            // 戻ってきた結果が良ければ情報を入れる
            switch result {
            case .success(let data):
                self.data = data
                // 会話の履歴を追加する
                setAssistantMessage(content: data.choices.first?.message.content ?? "no message")
                // Viewに表示するためのテキストを代入する
                fromChatGPT = data.choices.first?.message.content ?? "no Message" 
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
    
    /// データを削除します
    func deleteData() {
        // code here
    }
}
