//
//  ContentView.swift
//  VideoWithAsync
//
//  Created by 李竑陞 on 2023/6/16.
//

import SwiftUI
import PhotosUI
import AVKit

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.videos) { video in
                    VideoPlayer(player: AVPlayer(url: URL(string: video.videoUrl)!))
                        .frame(height: 250)
                }
            }
            .refreshable {
                Task {
                    try await viewModel.fetchVideos()
                }
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    PhotosPicker(selection: $viewModel.selectedItem,
                                 matching: .any(of: [.videos, .not(.images)])) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
