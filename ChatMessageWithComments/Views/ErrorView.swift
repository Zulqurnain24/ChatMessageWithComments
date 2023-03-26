//
//  ErrorView.swift
//  ChatMessageWithComments
//
//  Created by Mohammad Zulqurnain on 26/03/2023.
//

import SwiftUI

struct ErrorView: View {
  let error: Error
  let retryAction: () -> Void
  
  var body: some View {
    VStack(spacing: 16) {
      Text("Error: \(error.localizedDescription)")
        .foregroundColor(.red)
        .font(.headline)
      Button(action: retryAction) {
        Text("Retry")
      }
      .foregroundColor(.white)
      .padding(.vertical, 8)
      .padding(.horizontal, 16)
      .background(Color.blue)
      .cornerRadius(8)
    }
    .padding()
  }
}
