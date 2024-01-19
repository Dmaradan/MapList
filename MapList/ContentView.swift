//
//  ContentView.swift
//  MapList
//
//  Created by Diego Martin on 1/14/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))
    
    @State private var viewModel = ViewModel()
    @State private var defaultMap = true
    
    var body: some View {
        Group {
            if viewModel.isUnlocked {
                VStack {
                    MapReader { proxy in
                        Map(initialPosition: startPosition) {
                            ForEach(viewModel.locations) { location in
                                Annotation(location.name, coordinate: location.coordinate) {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .foregroundStyle(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .onLongPressGesture {
                                            viewModel.selectedPlace = location
                                        }
                                }
                            }
                        }
                        .mapStyle(defaultMap ? .standard : .hybrid)
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                viewModel.addLocation(at: coordinate)
                            }
                        }
                        .sheet(item: $viewModel.selectedPlace) { place in
                            EditView(location: place) { newLocation in
                                viewModel.update(location: newLocation)
                            }
                        }
                        .alert("Biometric Authentication failed", isPresented: $viewModel.authenticationAlertIsShowing) {
                            Text("Invalid biometric data detected")
                        }
                    }
                    Button("Switch map mode") {
                        defaultMap.toggle()
                    }
                }
            } else {
                Button("Authenticate to unlock", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .alert("Biometric Authentication failed", isPresented: $viewModel.authenticationAlertIsShowing) {
            Button("Ok") {}
        } message: {
            Text(viewModel.authenticationError)
        }
    }
}

#Preview {
    ContentView()
}
