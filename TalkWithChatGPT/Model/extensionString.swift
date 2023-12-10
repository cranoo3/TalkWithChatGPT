//
//  extensionString.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/10.
//

import Foundation

extension String {
    /// Markdownテキストとしてレンダリングする
    func getAttributedString() -> AttributedString {
        do {
            let attributedString = try AttributedString(markdown: self)
            return attributedString
        } catch {
            print("Couldn't parse: \(error)")
        }
        return AttributedString("Error parsing markdown")
    }
}
