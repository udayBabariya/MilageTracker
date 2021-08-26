//
//  HomeViewModel.swift
//  MilageTracker
//
//  Created by Uday on 25/08/21.
//


import CoreMotion

class HomeViewModel: NSObject {
    
    //MARK: Constants/var:-
    private let activityManager = CMMotionActivityManager()
    private let padoMeter = CMPedometer()
    private var trips = [Trip]()
    
    
    ///enum for activity status
    enum ActivityStatus{
        case running
        case stationary
        case walking
        case automotive
        case bicycle
        
        var value: String {
            switch self{
                
            case .running:
                return "Running"
            case .stationary:
                return "Stopped"
            case .walking:
                return "Walking"
            case .automotive:
                return "In Vehical"
            case .bicycle:
                return "Bicycle"
            }
        }
    }
    
    /// start tracking activity if feature is available in current device
    /// - Parameter handler: get event updates
    func startActivityManager(handler: @escaping (ActivityStatus)->()){
        if CMMotionActivityManager.isActivityAvailable(){
            self.activityManager.startActivityUpdates(to: .main) { data in
                DispatchQueue.main.async {
                    if let activity = data{
                        if activity.running{
                            print("Runnnnnning")
                            handler(.running)
                        }else if activity.stationary{
                            print("Stoped")
                            TripManager.shared.startBreak()
                            handler(.stationary)
                        }else if activity.walking{
                            print("walking")
                            TripManager.shared.resumeWalking()
                            handler(.walking)
                        }else if activity.automotive{
                            print("automotive")
                            handler(.automotive)
                        }else if activity.cycling{
                            print("bicycle")
                            handler(.bicycle)
                        }
                    }
                }
            }
        }
    }
    
    /// start step counting if feature is available in current device
    /// - Parameter handler: get response of padometer
    func startStepCounter(handler: @escaping (CMPedometerData)->()){
        if CMPedometer.isStepCountingAvailable(){
            self.padoMeter.startUpdates(from: Date()) { Data, Error in
                if Error != nil{
                   //error handling
                    print(Error?.localizedDescription as Any)
                }
                if let response = Data{
                    DispatchQueue.main.async {
                        handler(response)
                    }
                }
            }
        }
    } 
}
