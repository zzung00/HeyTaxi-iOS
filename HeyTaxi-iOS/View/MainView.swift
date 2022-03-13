//
//  MainView.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/07.
//

import SwiftUI
import MapKit

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: MapDefaults.latitude, longitude: MapDefaults.longitude),
        span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(MapDefaults.zoom), longitudeDelta: MapDefaults.zoom))
    
    private enum MapDefaults {
        static let latitude = 35.96322239939191
        static let longitude = 126.98783602642584
        static let zoom = 0.01
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true)
                    .ignoresSafeArea(edges: .all)
                    .scaledToFill()
                
                VStack {
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "car")
                    }
                    .frame(width: 60, height: 60, alignment: .center)
                    .background(Color.mainGreen)
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person")
                        }
                    }
                }
                .onAppear {
                    viewModel.loadMe()
                    viewModel.requestPermission()
                    viewModel.registerSocket()
                }
            }
        }.navigationBarHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
