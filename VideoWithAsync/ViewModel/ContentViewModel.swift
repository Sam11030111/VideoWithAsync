//
//  ContentViewModel.swift
//  VideoWithAsync
//
//  Created by 李竑陞 on 2023/6/16.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class ContentViewModel: ObservableObject {
    
    @Published var videos = [Video]()
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task{
                try await uploadVideo()
            }
        }
    }
    
    init() {
        Task {
            try await fetchVideos()
        }
    }
    
    func uploadVideo() async throws {
        guard let item = selectedItem else {
            return
        }
        
        guard let videoData = try await item.loadTransferable(type: Data.self) else {
            return
        }
        
        guard let videoUrl = try await VideoUploader.uploadVideo(withData: videoData) else {
            return
        }
        
        try await Firestore.firestore().collection("videos").document().setData(["videoUrl": videoUrl])
        
        print("Finish Video Upload...")
    }
    
    @MainActor
    func fetchVideos() async throws {
        let snapshot = try await Firestore.firestore().collection("videos").getDocuments()
        
        self.videos = snapshot.documents.compactMap({
            try? $0.data(as: Video.self)
        })
    }
}
