//
//  AddPersonView-ViewModel.swift
//  NameSaver
//
//  Created by Grace couch on 19/11/2024.
//
import PhotosUI
import SwiftUI

@Observable
class AddPersonViewModel {
    
    var selectedImage: PhotosPickerItem?
    var uiImage: UIImage?
    var name: String = ""
    var details: String = ""
    let locationFetcher = LocationFetcher.shared

    var processedImage: Image? {
        guard let uiImage else { return nil }
        return Image(uiImage: uiImage)
    }



    func loadImage() {
        Task {
            guard let imageData = try await selectedImage?.loadTransferable(type: Data.self) else { return }
            uiImage = UIImage(data: imageData)
        }
    }
}
