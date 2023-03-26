//
//  PostListView.swift
//  ChatMessageWithComments
//
//  Created by Mohammad Zulqurnain on 26/03/2023.
//

import SwiftUI

struct PostListView: View {
  @ObservedObject var postManager: PostManager
  
  var body: some View {
    switch postManager.state {
    case .idle, .loading:
      ProgressView()
        .onAppear {
          postManager.fetchPosts()
        }
    case .error(let error):
      ErrorView(error: error) {
        postManager.fetchPosts()
      }
    case .loaded(let posts):
      List(posts, id: \.id) { post in
        NavigationLink(destination: PostDetailView(post: post)) {
          VStack(alignment: .leading) {
            PostRowView(post: post)
            CommentsView(post: post)
          }
        }
      }.frame(minHeight: 0, maxHeight: .infinity)
      .onAppear {
        if postManager.posts.isEmpty {
          postManager.fetchPosts()
        }
      }
    }
  }
}
