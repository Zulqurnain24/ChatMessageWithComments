//
//  PostDetailView.swift
//  ChatMessageWithComments
//
//  Created by Mohammad Zulqurnain on 26/03/2023.
//

import SwiftUI
import URLImage

struct PostDetailView: View {
  let post: Post
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      VStack(alignment: .leading, spacing: 5) {
        Text(post.title)
          .font(.title)
        
        Text(post.body)
          .font(.body)
          .foregroundColor(.secondary)
        
        HStack {
          Text("Uploaded by \(post.author ?? "unkown") on \(post.dateString ?? "")")
            .font(.footnote)
            .foregroundColor(.secondary)
          
          Spacer()
          
          Button(action: {
            // toggle favorite state of post
          }) {
            Image(systemName: (post.isFavourite ?? false) ? "heart.fill" : "heart")
              .foregroundColor((post.isFavourite ?? false) ? .red : .primary)
          }
        }
      }
      .padding(.horizontal)
      .padding(.vertical, 10)
      
      Divider()
      
      CommentsView(post: post)
      
      Spacer()
    }
    .navigationBarTitle("Post Detail")
  }
}
