//
//  MenuButtonView.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/11.
//

import SwiftUI

struct MenuButtonView: View {
    var body: some View {
        VStack {
            // メニューを表示する(共有と削除)
            Menu() {
                // 共有ボタン
                Button() {
                    // share action
                } label: {
                    Image(systemName: "square.and.arrow.up")
                    Text("会話を共有")
                }
                
                // 削除ボタン
                Button(role: .destructive) {
                    // delete action
                } label: {
                    Image(systemName: "trash.fill")
                    Text("会話の履歴を削除")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.black)
                    .frame(width: 30, height: 30)
                    .padding(.horizontal, 5)
            }
        }
    }
}

#Preview {
    MenuButtonView()
}
