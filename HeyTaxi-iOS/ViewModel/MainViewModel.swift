//
//  MainViewModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/08.
//

import Foundation
import CoreLocation
import StompClientLib
import SwiftUI
import MapKit

class MainViewModel: NSObject, ObservableObject, CLLocationManagerDelegate, StompClientLibDelegate {
    private let url = NSURL(string: "ws://\(HeyTaxiService.host)/heytaxi-ws/websocket")
    @Published private var socketClient = StompClientLib()
    @Published var user: UserModel?
    @Published var taxi: TaxiModel?
    @Published var authorizationStatus: CLAuthorizationStatus
    private let locationManager: CLLocationManager
    @Published var lastSeenLocation: CLLocation?
    private var status = TaxiStatus.off
    var taxis: [Int: EmptyCarModel] = [:]
    var arr = [taxiMarker]()
    @State private var errorAlert:Bool = false
    @Published var reserveAlert:Bool = false
    @Published var reservationInfo: ReservationModel?
    @Published var waiting = false
    
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
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as! URL), delegate: self as! StompClientLibDelegate, connectionHeaders: ["Authorization": TokenUtils.getToken(serviceID: HeyTaxiService.baseUrl)!])
    }
    
    func subscribe() {
        socketClient.subscribe(destination: "/user/topic/error")
        socketClient.subscribe(destination: "/user/topic/reservation")
        socketClient.subscribe(destination: "/topic/empty") //빈차정보불러올때 쓰기
    }
    
    //택시 요청 큐에 승객 위치 보냄
    func requestCall() {
        var location: CallModel = CallModel(src: LocationModel(latitude: Double(lastSeenLocation?.coordinate.latitude ?? 0), longitude: Double(lastSeenLocation?.coordinate.longitude ?? 0)), dst: LocationModel(latitude: Double(lastSeenLocation?.coordinate.latitude ?? 0), longitude: Double(lastSeenLocation?.coordinate.longitude ?? 0)))
        let encoder = try! JSONEncoder().encode(location)
        let result = String(data: encoder, encoding: .utf8)
        
        socketClient.sendMessage(message: result!, toDestination: "/app/call/request", withHeaders: ["Authorization": TokenUtils.getToken(serviceID: HeyTaxiService.baseUrl)!, "content-type": "application/json"], withReceipt: nil)
    }
    
    //택시 요청 취소
    func cancelCall() {
        socketClient.sendMessage(message: "", toDestination: "/app/call/cancel", withHeaders: ["Authorization": TokenUtils.getToken(serviceID: HeyTaxiService.baseUrl)!, "content-type": "application/json"], withReceipt: nil)
    }
    
    func disconnect() {
        socketClient.disconnect()
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        let data = try! JSONSerialization.data(withJSONObject: jsonBody!, options: .prettyPrinted)
        let decoder = JSONDecoder()
        
        switch destination {
        case "/topic/error" :
            errorAlert = true
            let errorResponse = try! decoder.decode(ErrorModel.self, from: data)
            print(errorResponse)
        case "/user/topic/reservation" :
            //빈차는 안보이게, 예약알림 다이얼로그 및 예약된 택시만 보이게
            reservationInfo = try! decoder.decode(ReservationModel.self, from: data)
            waiting = false
            reserveAlert = true
        case "/topic/empty" :
            //택시 위치 dictionary에 저장
            let emptyResponse = try! decoder.decode(EmptyCarModel.self, from: data)
            taxis[emptyResponse.taxi!.id] = emptyResponse
            arr = taxis.map({(key: Int, value: EmptyCarModel) -> taxiMarker in return taxiMarker(name: value.taxi!.name, coordinate: CLLocationCoordinate2D(latitude: value.location.latitude, longitude: value.location.longitude))})
            print(emptyResponse)
        default:
            return
        }
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected!!!")
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        print("Socket is Connected!!!")
        subscribe()
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("receipt: \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error send: \(description)")
        socketClient.disconnect()
        registerSocket()
    }
    
    func serverDidSendPing() {
        print("Server ping")
    }
}
