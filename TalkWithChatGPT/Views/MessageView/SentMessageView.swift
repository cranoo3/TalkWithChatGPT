//
//  SentMessageView.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/16.
//

import SwiftUI

struct SentMessageView: View {
    let message: String
    
    var body: some View {
            HStack {
                Spacer()
                Text(message)
                    .textSelection(.enabled)
                    .padding(5)
                    .padding(.horizontal, 5)
                    .foregroundStyle(Color.white)
                    .background(Color.purple.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                    .frame(maxWidth: 330, alignment: .trailing)
            }
            .padding(.trailing)
            .padding(.bottom)
        }
}

#Preview {
    SentMessageView(message: "hogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehoge")
}
