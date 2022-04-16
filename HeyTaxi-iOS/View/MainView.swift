//
//  MainView.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/07.
//

import SwiftUI
import MapKit

struct taxiMarker: Identifiable {
    let id = UUID()
    let name: String
    dynamic var coordinate: CLLocationCoordinate2D
}

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: MapDefaults.latitude, longitude: MapDefaults.longitude),
        span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(MapDefaults.zoom), longitudeDelta: MapDefaults.zoom))

    //사용자 위치에 맞게 조정되게 변경 예정
    private enum MapDefaults {
        static let latitude = 37.33180
        static let longitude = -122.02978
        static let zoom = 0.01
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: viewModel.arr, annotationContent: {taxi in
                    MapAnnotation(coordinate: taxi.coordinate) {
                        Image("taxi")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                })
                .ignoresSafeArea(edges: .all)
                .scaledToFill()
                
                if viewModel.waiting == true {
                    ZStack {
                        VStack(alignment: .center, spacing: 25) {
                            Text("🚕")
                            Text("예약콜 대기 중...")
                                .bold()
                        }
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.mainGreen)
                    .cornerRadius(8)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                }
                
                VStack {
                    Spacer()
                    
                    if viewModel.waiting == false {
                        Button(action: {
                            viewModel.requestCall()
                            viewModel.waiting = true
                        }) {
                            Image(systemName: "car")
                                .foregroundColor(.white)
                        }
                        .frame(width: 60, height: 60, alignment: .center)
                        .background(Color.mainGreen)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
                    }
                    else {
                        Button(action: {
                            viewModel.cancelCall()
                            viewModel.waiting = false
                        }) {
                            Image(systemName: "multiply")
                                .foregroundColor(.white)
                        }
                        .frame(width: 60, height: 60, alignment: .center)
                        .background(Color.red)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
                    }
                    
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
                
                .alert(isPresented: $viewModel.reserveAlert) {
                    Alert(title: Text("HeyTaxi"), message: Text("\(String(describing: viewModel.reservationInfo!.taxi.taxi!.carNumber)) 택시가 예약되었습니다"), dismissButton: .default(Text("확인")))
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
