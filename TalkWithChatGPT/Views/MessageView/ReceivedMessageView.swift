//
//  ReceivedMessageView.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/16.
//

import SwiftUI

struct ReceivedMessageView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State private var rectangleCornerRadius: CGFloat = 15.0
    let model: String
    let message: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(model)
                    .textCase(.uppercase)
                    .foregroundStyle(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(message)
                    .textSelection(.enabled)
                    .padding(5)
                    .padding(.horizontal, 5)
                    .foregroundStyle(Color.black)
                    .background(Color.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: rectangleCornerRadius))
                    .frame(maxWidth: 330, alignment: .leading)
                    
            }
            
            Spacer()
        }
        .padding(.leading)
        .padding(.bottom)
    }
}

#Preview {
    ReceivedMessageView(viewModel: ContentViewModel(), model: "assistant", message: "hogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehoge")
}
