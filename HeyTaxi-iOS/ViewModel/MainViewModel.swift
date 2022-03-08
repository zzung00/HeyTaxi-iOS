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
    private var status = TaxiStatus.off
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func loadMe() {
        HeyTaxiService.shared.loadMe {
            result in
            if (result.success) {
                self.user = result.user
            }
        }
    }
    
    //빈 차인 경우, 위치 변경 될 때마다 실시간 업데이트
    //승객이 자신 주변의 빈 차 유무를 알 수 있게 하기 위해 빈 차를 보여줌
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
        if(status == TaxiStatus.empty) {
            //sendLocation()
        }
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func setStatus(status: TaxiStatus) {
        self.status = status
    }
    
    //socket connection
    func registerSocket() {
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as! URL), delegate: self as! StompClientLibDelegate, connectionHeaders: ["Authorizaion": TokenUtils.getToken(serviceID: HeyTaxiService.baseUrl)!])
    }
    
    func subscribe() {
        socketClient.subscribe(destination: "/user/topic/error")
        socketClient.subscribe(destination: "/user/\((self.user!.username)!)/topic/reservation")
        socketClient.subscribe(destination: "/topic/empty")
    }
    
    func sendLocation() {
        var location: EmptyCarModel = EmptyCarModel(taxi: nil, location: LocationModel(latitude: Double(lastSeenLocation?.coordinate.latitude ?? 0), longtitude: Double(lastSeenLocation?.coordinate.longitude ?? 0)))
        let encoder = try! JSONEncoder().encode(location)
        let result = String(data: encoder, encoding: .utf8)
        
        socketClient.sendMessage(message: result!, toDestination: "/app/empty/update", withHeaders: ["Authorization": TokenUtils.getToken(serviceID: HeyTaxiService.baseUrl)!, "content-type": "application/json"], withReceipt: nil)
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        <#code#>
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        <#code#>
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        <#code#>
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        <#code#>
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        <#code#>
    }
    
    func serverDidSendPing() {
        <#code#>
    }
}
