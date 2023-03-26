//
//  PostState.swift
//  ChatMessageWithComments
//
//  Created by Mohammad Zulqurnain on 26/03/2023.
//

import Foundation

enum PostManagerState {
  case idle
  case loading
  case loaded([Post])
  case error(Error)
}
