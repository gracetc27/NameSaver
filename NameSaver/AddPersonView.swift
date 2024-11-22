//
//  AddPersonView.swift
//  NameSaver
//
//  Created by Grace couch on 19/11/2024.
//

import PhotosUI
import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = AddPersonViewModel()
    let saveAction: (Person) -> Void

    var isInValid: Bool {
        if viewModel.uiImage == nil || viewModel.name.isEmpty || viewModel.details.isEmpty || viewModel.locationFetcher.lastKnownLocation == nil {
            return true
        } else {
            return false
        }
    }


    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Add Name", text: $viewModel.name)
                    TextField("Extra Info", text: $viewModel.details)
                }
                Section {
                    PhotosPicker(selection: $viewModel.selectedImage) {
                        if let processedImage = viewModel.processedImage {
                            processedImage
                                .resizable()
                                .scaledToFit()
                        } else {
                            ContentUnavailableView("No Photo", systemImage: "photo.badge.plus", description: Text("Tap to select a photo"))
                        }
                    }
                    .onChange(of: viewModel.selectedImage, viewModel.loadImage)
                }
            }
            .toolbar {
                Button("Save") {
                    if let uiImage = viewModel.uiImage, let lastKnownLocation = viewModel.locationFetcher.lastKnownLocation {
                        let location = Location(
                            id: UUID(),
                            latitude: lastKnownLocation.latitude,
                            longitude: lastKnownLocation.longitude)

                        let person = Person(
                            id: UUID(),
                            name: viewModel.name,
                            uiImage: uiImage,
                            details: viewModel.details,
                            pinLocation: location
                        )
                        saveAction(person)
                        dismiss()
                    }
                }
                .disabled(isInValid)
            }
        }
    }
}

#Preview {
    AddPersonView(saveAction: {_ in })
}
