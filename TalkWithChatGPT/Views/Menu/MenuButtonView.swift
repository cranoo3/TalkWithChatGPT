//
//  MenuButtonView.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/11.
//

import SwiftUI

struct MenuButtonView: View {
    @State var isShowDeleteAlert = false
    
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
                    isShowDeleteAlert = true
                } label: {
                    Image(systemName: "trash.fill")
                    Text("会話の履歴を削除")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.accentColor)
                    .frame(width: 15, height: 30)
                    .padding(.horizontal, 5)
            }
        }
        .alert("会話データを削除しますか？", isPresented: $isShowDeleteAlert) {
            Button(role: .cancel) {
                // 何もしないので処理はなし
            } label: {
                Text("いいえ")
            }
            Button(role: .destructive) {
                // code
            } label: {
                Text("はい")
            }
            
        } message: {
            Text("今までの会話データが削除されます。よろしいですか？")
        }
    }
}

#Preview {
    MenuButtonView()
}
