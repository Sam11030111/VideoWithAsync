//
//  ContentView.swift
//  VideoWithAsync
//
//  Created by 李竑陞 on 2023/6/16.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0...3, id: \.self) { video in
                    Text("Video goes here...")
                }
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    PhotosPicker(selection: $viewModel.selected,
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
