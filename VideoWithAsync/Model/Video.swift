//
//  Video.swift
//  VideoWithAsync
//
//  Created by 李竑陞 on 2023/6/17.
//

import Foundation

struct Video: Identifiable, Decodable {
    let videoUrl: String
    var id: String {
        return UUID().uuidString
    }
}
