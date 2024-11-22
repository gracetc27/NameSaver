//
//  PersonDetailView.swift
//  NameSaver
//
//  Created by Grace couch on 19/11/2024.
//
import MapKit
import SwiftUI



struct PersonDetailView: View {
    var person: Person

    var startingPosition: MapCameraPosition { MapCameraPosition.region( MKCoordinateRegion(
        center: person.pinLocation.coordinate,
        span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
    )
    )
    }
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomLeading) {
                MapReader { proxy in
                    Map(initialPosition: startingPosition) {
                        Annotation(person.name, coordinate: person.pinLocation.coordinate) {
                            Image(uiImage: person.uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 36, height: 36)
                                .clipShape(.circle)
                        }
                    }
                }
                VStack {
                    Text(person.details)
                        .font(.headline)
                }
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial, ignoresSafeAreaEdges: .bottom)
            }
            .toolbarBackground(.ultraThinMaterial)
            .navigationTitle(person.name)

        }
    }
}

#Preview {
    PersonDetailView(person: Person(id: UUID(), name: "Grace", uiImage: UIImage(named: "lolaAndFlower")!, details: "llalala", pinLocation: .example))
}
