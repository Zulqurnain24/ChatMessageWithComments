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
  var imageUrl: String? = "https://media.istockphoto.com/id/486242045/vector/sample-red-3d-realistic-paper-speech-bubble-isolated-on-white.jpg?s=612x612&w=0&k=20&c=H7a_5jtJvmrr_VtdvHpb4C8D4BLue9Hr1IlTvtG_Khw="
  var isFavourite: Bool? = false
  var dateString: String? = ""
  var author: String? = ""
  var comments: [Comment]? = []
}
