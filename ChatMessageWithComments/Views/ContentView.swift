
import SwiftUI

struct ContentView: View {
  @ObservedObject var postManager: PostManager
  
  var body: some View {
    Group {
      NavigationView {
        if postManager.isLoading {
          ProgressView()
        } else if let error = postManager.error {
          ErrorView(error: error, retryAction: postManager.fetchPosts)
        } else if !postManager.posts.isEmpty {
            PostListView(postManager: PostManager())
                .background(Color.primary)
        } else {
          Text("No posts found.")
        }
      }
    }
    .navigationBarTitle("Posts")
    .onAppear {
      postManager.fetchPosts()
    }
  }
}
