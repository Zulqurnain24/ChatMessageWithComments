//
//  ChatMessageWithCommentsApp.swift
//  ChatMessageWithComments
//
//  Created by Muhammad Zulqurnain on 24/03/2023.
//

import SwiftUI
import UIKit

@main
struct ChatMessageWithCommentsApp: App {
    var body: some Scene {
        WindowGroup {
          ContentView(postManager: PostManager())
        }
    }
}
