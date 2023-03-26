//
//  PostRowView.swift
//  ChatMessageWithComments
//
//  Created by Mohammad Zulqurnain on 26/03/2023.
//

import SwiftUI

struct PostRowView: View {
  let post: Post
  
  var body: some View {
    HStack(spacing: 16) {
        VStack(alignment: .leading, spacing: 4) {
        Text(post.title)
          .font(.headline)
          .lineLimit(2)
        Text(post.body)
          .font(.subheadline)
          .foregroundColor(.secondary)
          .lineLimit(3)
      }
      if post.isFavourite ?? false {
        Image(systemName: "heart.fill")
          .foregroundColor(.red)
      }
    }
  }
}
