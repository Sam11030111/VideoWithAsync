//
//  ContentViewModel.swift
//  VideoWithAsync
//
//  Created by 李竑陞 on 2023/6/16.
//

import Foundation
import SwiftUI
import PhotosUI

class ContentViewModel: ObservableObject {
    
    @Published var selected: PhotosPickerItem? {
        didSet {
            
        }
    }
}
