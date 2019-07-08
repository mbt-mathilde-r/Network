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
  let sessionId: String
  let sessionIndex: Int // WTF ?
  let startedAt: TimeInterval
  let duration: Int
  let relaxIndexByThresholds: [Float]
  let phase: Int
  let level: Int
}
