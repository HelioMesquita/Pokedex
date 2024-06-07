//
//  BuilderProtocol.swift
//  Infrastructure
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation

protocol BuilderProtocol {

  associatedtype ResponseType: Decodable
  associatedtype ModelType

  func build(response: ResponseType) throws -> ModelType
}
