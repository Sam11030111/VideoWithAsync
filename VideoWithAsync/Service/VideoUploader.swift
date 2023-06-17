//
//  VideoUploader.swift
//  VideoWithAsync
//
//  Created by 李竑陞 on 2023/6/16.
//

import Foundation
import FirebaseStorage

struct VideoUploader {
    
    static func uploadVideo(withData videodata: Data) async throws -> String? {
        let fileName = UUID().uuidString
        let ref = Storage.storage().reference().child("/video/\(fileName)")
        
        let metaData = StorageMetadata()
        metaData.contentType = "video/quicktime"
        
        do {
            let _ = try await ref.putDataAsync(videodata, metadata: metaData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("Fail to upload video with error: \(error.localizedDescription)")
            return nil
        }
    }
}
