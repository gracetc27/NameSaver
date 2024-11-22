//
//  Person.swift
//  NameSaver
//
//  Created by Grace couch on 19/11/2024.
//
import MapKit
import SwiftUI

enum ImageDecodingError: Error {
    case invalidImageData
}

struct Person: Identifiable, Codable, Comparable {
    enum CodingKeys: CodingKey {
            case id, name, uiImage, details, pinLocation
        }
    let id: UUID
    var name: String
    var uiImage: UIImage
    var details: String
    var pinLocation: Location

    init(id: UUID, name: String, uiImage: UIImage, details: String, pinLocation: Location) {
        self.id = id
        self.name = name
        self.uiImage = uiImage
        self.details = details
        self.pinLocation = pinLocation
    }

    init(from decoder: any Decoder) throws {
        let container = try  decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.details = try container.decode(String.self, forKey: .details)
        self.pinLocation = try container.decode(Location.self, forKey: .pinLocation)
        let imageData = try container.decode(Data.self, forKey: .uiImage)

        if let decodedImage = UIImage(data: imageData) {
            self.uiImage = decodedImage
        } else {
            throw ImageDecodingError.invalidImageData
        }
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(details, forKey: .details)
        try container.encode(pinLocation, forKey: .pinLocation)
        if let jpegImage = uiImage.jpegData(compressionQuality: 0.8) {
            try container.encode(jpegImage, forKey: .uiImage)
        }
    }

    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }

    static func ==(lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
}
