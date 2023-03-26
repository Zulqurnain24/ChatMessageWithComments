//
//  PostsManager.swift
//  ChatMessageWithComments
//
//  Created by Mohammad Zulqurnain on 26/03/2023.
//

import Combine
import Foundation

class PostManager: ObservableObject {
  @Published var posts: [Post] = []
  @Published var isLoading = false
  @Published var error: Error?
  @Published var state: PostManagerState
  
  private let session: URLSession
  private var cancellables = Set<AnyCancellable>()
  private var favouritePosts: Set<Int> = []
  
  init(session: URLSession = .shared) {
    self.session = session
    self.state = .loading
  }
  
  func fetchPosts() {
    isLoading = true
    error = nil
    
    guard let postsURL = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
    let postPublisher = session.dataTaskPublisher(for: postsURL)
      .map { $0.data }
      .decode(type: [Post].self, decoder: JSONDecoder())
    
    guard let commentURL = URL(string: "https://jsonplaceholder.typicode.com/comments") else { return }
    let commentPublisher = session.dataTaskPublisher(for: commentURL)
      .map { $0.data }
      .decode(type: [Comment].self, decoder: JSONDecoder())
    
    Publishers.Zip(postPublisher, commentPublisher)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] completion in
        self?.isLoading = false
        
        switch completion {
        case .failure(let error):
          self?.error = error
        case .finished:
          break
        }
      }, receiveValue: { [weak self] (posts, comments) in
        self?.posts = posts.map { post in
          var post = post
          post.comments = comments.filter { $0.id == post.id }
          post.isFavourite = self?.favouritePosts.contains(post.id) ?? false
          return post
        }
        self?.state = .loaded(self?.posts ?? [])
      })
      .store(in: &cancellables)
  }
  
  func toggleFavouriteStatus(for post: Post) {
    if favouritePosts.contains(post.id) {
      favouritePosts.remove(post.id)
    } else {
      favouritePosts.insert(post.id)
    }
    
    if let index = posts.firstIndex(where: { $0.id == post.id }) {
      posts[index].isFavourite?.toggle()
    }
  }
}
