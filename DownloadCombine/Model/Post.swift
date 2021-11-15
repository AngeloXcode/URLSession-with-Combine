//
//  Post.swift
//  DownloadCombine
//
//  Created by Angelo Essam on 15/11/2021.
//

import Foundation
import SwiftUI

struct Post : Codable,Identifiable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID
        case id, title, body
    }
}

typealias PostModel = [Post]
