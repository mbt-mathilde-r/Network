//
//  MeloRequestModel.swift
//  Network
//
//  Created by Mathilde Ressier on 08/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import Foundation

struct MeloHeader: Codable {
  let version: String
  let objets: Int
  let limit: Int
  let offset: Int
  let total: Int
}

struct MeloRequestModel<DataItemType: Codable>: Codable {
  let header: MeloHeader
  let data: [DataItemType]
}
