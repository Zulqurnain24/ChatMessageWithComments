//
//  ViewModel.swift
//  ChatMessageWithComments
//
//  Created by Mohammad Zulqurnain on 26/03/2023.
//

import Combine
import Foundation

class PostsViewModel: ObservableObject {
  @Published var posts: [Post] = []
  private let networkManager = NetworkManager()
  private let commentsNetworkManager = NetworkManager()
  
  init() {
    fetchPosts()
  }
  
  func fetchPosts() {
    guard let postsURL = URL(string: "https://yourapi.com/posts"),
          let commentsURL = URL(string: "https://yourapi.com/comments")else { return }
    
    let postsPublisher: AnyPublisher<PostsResponse, APIError> = networkManager.get(url: postsURL)
    let commentsPublisher: AnyPublisher<[Comment], APIError> = commentsNetworkManager.get(url: commentsURL)
    
    Publishers.Zip(postsPublisher, commentsPublisher)
      .map { (postsResponse, comments) in
        postsResponse.posts.map { post in
          var updatedPost = post
          updatedPost.comments = comments.filter { $0.id == post.id }
          return updatedPost
        }
      }
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          print(error.localizedDescription)
        }
      }, receiveValue: { [weak self] posts in
        self?.posts = posts
      })
      .store(in: &cancellables)
  }
  
  private var cancellables = Set<AnyCancellable>()
  
  func toggleFavourite(post: Post) {
    if let index = posts.firstIndex(where: { $0.id == post.id }) {
      posts[index].isFavourite?.toggle()
    }
  }
}
