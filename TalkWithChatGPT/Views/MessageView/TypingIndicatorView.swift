//
//  TypingIndicatorView.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/17.
//

import SwiftUI

struct TypingIndicatorView: View {
    // 無限アニメーション用
    @State var isAnimating = false
    let model: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model)
                .textCase(.uppercase)
                .foregroundStyle(Color.gray)
            
            HStack {
                Circle()
                    .fill(isAnimating ? Color.purple : Color.indigo)
                    .frame(width: 7)
                    .scaleEffect(self.isAnimating ? 0.5: 1)
                    .animation(Animation.spring().repeatForever(), value: isAnimating)
                
                Circle()
                    .fill(isAnimating ? Color.purple : Color.indigo)
                    .frame(width: 7)
                    .scaleEffect(self.isAnimating ? 0.5: 1)
                    .animation(Animation.spring().repeatForever().delay(0.1), value: isAnimating)
                
                Circle()
                    .fill(isAnimating ? Color.purple : Color.indigo)
                    .frame(width: 7)
                    .scaleEffect(self.isAnimating ? 0.5: 1)
                    .animation(Animation.spring().repeatForever().delay(0.2), value: isAnimating)
            }
            .padding(.leading)
            .onAppear {
                self.isAnimating = true
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TypingIndicatorView(model: "hogehoge")
}
