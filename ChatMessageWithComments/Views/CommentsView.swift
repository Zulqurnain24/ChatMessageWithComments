//
//  CommentsView.swift
//  ChatMessageWithComments
//
//  Created by Mohammad Zulqurnain on 26/03/2023.
//

import SwiftUI

struct CommentsView: View {
  @State var post: Post
    
  var body: some View {
    VStack(alignment: .leading) {
      Text("Comments")
        .font(.title2)
        .bold()
      
      if let comments = post.comments {
        if comments.isEmpty {
          Text("No comments yet.")
                .foregroundColor(.secondary)
        } else {
          List(comments, id: \.id) { comment in
              Text(comment.text ?? "No Text")
                .font(.body)
                .foregroundColor(.primary)
              
              HStack {
                Text("By \(comment.author ?? "") on \(comment.dateString ?? "")")
                  .font(.footnote)
                  .foregroundColor(.secondary)
              }
          }.listStyle(.inset)
        }
      } else {
        Text("Loading comments...")
          .foregroundColor(.secondary)
      }
    }
  }
}
