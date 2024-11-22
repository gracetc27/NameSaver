//
//  PersonListView.swift
//  NameSaver
//
//  Created by Grace couch on 19/11/2024.
//

import SwiftUI

struct PersonListView: View {
    @State private var viewModel = PersonListViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.people.sorted()) { person in
                    NavigationLink {
                        PersonDetailView(person: person)
                    } label: {
                        HStack {
                            Image(uiImage: person.uiImage)
                                .resizable()
                                .scaledToFit()
                                .clipShape(.circle)
                                .frame(width: 75, height: 75)
                            Text(person.name)
                                .font(.headline)
                        }
                    }
                }
            }
            .toolbar {
                Button("Add person", systemImage: "plus") {
                    viewModel.sheetPresent = true
                    viewModel.locationFetcher.start()
                }
            }
            .sheet(isPresented: $viewModel.sheetPresent) {
                AddPersonView() { person in
                    viewModel.save(person: person)
                }
            }
            .navigationTitle("NameSaver")
        }
    }
}

#Preview {
    PersonListView()
}
