//
//  SessionHistory.swift
//  Network
//
//  Created by Mathilde Ressier on 08/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import Foundation

struct SessionHistory: Codable {
  let id: String
  let schemaName: String
  let sessionId: String // Index of the session in BDD
  let sessionIndex: Int // Index of the session for the user
  let startedAt: TimeInterval
  let duration: Int
  let relaxIndexByThresholds: [Float]
  let phase: Int
  let level: Int
}

struct SessionHistoryParameters: Codable {
  var phase: Int?
  var level: Int?
  var _limit: Int?
  var _skip: Int?
  var _sort_order: Int?
}
