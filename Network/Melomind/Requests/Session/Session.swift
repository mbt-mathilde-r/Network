//
//  Session.swift
//  Network
//
//  Created by Mathilde Ressier on 08/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import Foundation

struct EegKpis: Codable {
  let relaxIndex: [Float]
  let averageAreaAboveThreshold: Float
  let performance: Float
  let switches: Float
}

struct Session: Codable {
  let id: String
  let schemaName: String
  let userId: String
  let startedAt: TimeInterval
  let exerciseType: String
  let goal: Int // is it used anymore ?
  let duration: Int
  let completed: Bool
  let aborted: Bool
  let eegKpis: EegKpis
  let level: Int
  let phase: Int
}
