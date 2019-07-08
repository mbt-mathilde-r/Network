//
//  GetConfig.swift
//  Network
//
//  Created by Mathilde Ressier on 08/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import Foundation

struct NFConfig: Codable {
  let thresholds: [Float]
}

//----------------------------------------------------------------------------
// MARK: - Level
//----------------------------------------------------------------------------

struct ConfigLevel: Codable {
  let name: String
  let index: Int
  let messages: [String: String]
  let bounds: [Int]
}

//----------------------------------------------------------------------------
// MARK: - Phase
//----------------------------------------------------------------------------

struct ConfigPhase: Codable {
  let name: String
  let index: Int
  let messages: [String: String]
  let bounds: [Int]
  let levels: [ConfigLevel]
}

//----------------------------------------------------------------------------
// MARK: - Config
//----------------------------------------------------------------------------

struct Config: Codable {
  let maxNbOfSession: Int
  let sessionsDuration: [Int]
  let staiEtatGranularity: Int
  let initialNbOfTable: Int
  let unlockTableSessionNb: [Int]
  let unlockFreeSessionSessionNb: [Int]
  let guidedMode: Bool
  let onboarding: Bool
  let displayFreeSessionWarning: Bool
  let nfConfig : NFConfig
  let phases: [ConfigPhase]
}
