//
//  PersonListView-ViewModel.swift
//  NameSaver
//
//  Created by Grace couch on 19/11/2024.
//

import SwiftUI

@Observable
class PersonListViewModel {
    var sheetPresent = false
    var people: [Person]
    let locationFetcher = LocationFetcher.shared

    let savePath = URL.documentsDirectory.appending(path: "SavedPeople")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            print(error.localizedDescription)
            people = []
        }
    }

    func save(person: Person) {
        do {
            people.append(person)
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
