//
//  RequestError.swift
//  Infrastructure
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation

enum RequestError: Int, Error, LocalizedError, Equatable {

  typealias RawValue = Int

  case unknownError = 0
  case invalidParser = 1
  case badRequest = 400
  case unauthorized = 401
  case forbidden = 403
  case notFound = 404
  case serverError = 500

  var localizedDescription: String {
    return String(describing: self)
  }

}
