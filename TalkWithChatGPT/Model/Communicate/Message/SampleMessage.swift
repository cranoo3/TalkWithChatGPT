//
//  SampleMessage.swift
//  TalkWithChatGPT
//
//  Created by cranoo3 on 2023/12/11.
//

import Foundation

/// Viewの表示を確認するためのサンプルメッセージです
struct SampleMessage {
    let sampleTextShort = "こんにちは"
    
    let sampleTextLong = """
SwiftUIを使用してボタンを表示するには、以下のようにコードを記述できます。以下は、基本的な例です。

swift
Copy code
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("タップしてください") {
                // ボタンがタップされたときの処理をここに追加します
                print("ボタンがタップされました")
            }
            .padding()
        }
    }
}

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
この例では、VStackを使用して垂直に要素を配置し、その中にButtonがあります。ボタンがタップされたときの処理は、ボタンのクロージャ内で行います。この例では、単純にコンソールにメッセージを出力していますが、実際のアプリケーションでは必要な処理をここに追加します。

SwiftUIでは、UIの構築や更新がデータ駆動型で行われるため、ボタンがタップされたときに表示を更新したい場合は、@Stateや@Bindingなどのプロパティを使用して状態を管理することが一般的です。

swift
Copy code
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("タップしてください") {
                // ボタンがタップされたときの処理をここに追加します
                print("ボタンがタップされました")
            }
            .padding()
        }
    }
}

"""
}
