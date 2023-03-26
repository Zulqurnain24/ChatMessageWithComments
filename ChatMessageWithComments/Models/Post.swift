//
//  Post.swift
//  ChatMessageWithComments
//
//  Created by Mohammad Zulqurnain on 26/03/2023.
//

import Foundation

struct Post: Codable, Identifiable {
  let id: Int
  let title: String
  let body: String
  var isFavourite: Bool? = false
  var dateString: String? = ""
  var author: String? = ""
  var comments: [Comment]? = []
}
