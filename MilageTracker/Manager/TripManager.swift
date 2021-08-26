//
//  TripManager.swift
//  MilageTracker
//
//  Created by Uday on 26/08/21.
//

import Foundation

///TRIP MANAGER -  manage trip activity
class TripManager{
    
    ///singleton shared instance
    static let shared = TripManager()
    
    private init() {
        currentTrip = Trip(startTime: Date(), endTime: Date(), totalSteps: 0, peace: 0, status: false, distance: 0)
    }
   
    //timer
    var timer = Timer()
    
    /// to track active trip Status
    var isTripActive = false
    
    /// current trip
    var currentTrip: Trip
    
    lazy var allTrips: [Trip] = {
        return fetchAllTripFromUserDefaults() ?? [currentTrip]
    }()
    
    /// to track break time of user
    // if stops for 5 mins (300 Sec) then store as 1 trip.
    var breakTime = 0{
        didSet{
            if breakTime > 10{
                print("break time exceed")
                currentTrip.endTime = Date()
                self.storeCurrentTrip() { [weak self] in
                    self?.startNewTrip()
                }
            }
        }
    }
    
    /// store current active trip into userDefaults
    func storeCurrentTrip(success: @escaping ()->()){
        UserDefaults.standard.set(try? PropertyListEncoder().encode([currentTrip]), forKey:"currentTrip")
        success()
    }
    
    ///to start new trip
    func startNewTrip(){
        currentTrip = Trip(startTime: Date(), endTime: Date(), totalSteps: 0, peace: 0, status: false, distance: 0)
        timer.invalidate()
        breakTime = 0
    }
    
    /// to get all the trips stored in userDefaults
    func fetchAllTripFromUserDefaults() -> [Trip]? {
        var result: [Trip]?
        if let tripsData = UserDefaults.standard.value(forKey:"currentTrip") as? Data{
            do{
                guard let trips = try? PropertyListDecoder().decode([Trip].self, from: tripsData) else { return nil }
                result = trips
            }
        }
        print("fetch Trips success",result as Any)
        return result
    }
    
    /// calculateBreakTime
    func startBreak(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self
                                     , selector: #selector(updateCurrentBreakTime), userInfo: nil, repeats: true)
    }
    
    /// to update breakTime duration
    @objc private func updateCurrentBreakTime(){
        breakTime += 1
    }
    
    /// to resume from break
    func resumeWalking(){
        timer.invalidate()
        breakTime = 0
    }
    
}
