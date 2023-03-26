//
//  Comment.swift
//  ChatMessageWithComments
//
//  Created by Mohammad Zulqurnain on 26/03/2023.
//

import Foundation

struct Comment: Codable, Identifiable {
  let id: Int
  let text: String?
  let author: String?
  let dateString: String?
  let date: Date?
}
