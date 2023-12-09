//
//  Common.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/08.
//

import Foundation


/// plistを取得する構造体
/// plistの内容は辞書になっています
struct Common {
    static let shared = Common()
    var plist: [String: String] = [:]
    
    // シングルトン化
    private init() {
        guard let url = Bundle.main.url(forResource: "Application",
                                        withExtension: "plist") else { return }
        // Dataとして読み込み
        do {
            let data = try Data(contentsOf: url)
            let plistTemp = try PropertyListSerialization.propertyList(from: data,
                                                                       options: .mutableContainers,
                                                                       format: nil)
            
            guard let plist = plistTemp as? [String: String] else { return }
            self.plist = plist
        } catch {
            fatalError()
        }
    }
    
    
    /// 渡されたキーを検索し、一致するものがあれば値を返します
    /// なければ`nil`になるので注意
    /// - Parameter key: plistのキーを入力。String型
    /// - Returns: valueを返す。String?型なので注意
    func getValue(key: String) -> String? {
        return plist[key]
    }
}
