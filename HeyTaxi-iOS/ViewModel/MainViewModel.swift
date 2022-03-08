//
//  MainViewModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/08.
//

import Foundation
import CoreLocation
import StompClientLib

class MainViewModel: NSObject, ObservableObject, CLLocationManagerDelegate, StompClientLibDelegate {
    private let url = NSURL(string: "ws://\(HeyTaxiService.host)/heytaxi-ws/websocket")
    @Published private var socketClient = StompClientLib()
    @Published var user: UserModel?
    @Published var taxi: TaxiModel?
    @Published var authorizationStatus: CLAuthorizationStatus
    private let locationManager: CLLocationManager
    @Published var lastSeenLocation: CLLocation?
    //private var status
}
