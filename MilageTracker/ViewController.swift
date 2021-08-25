//
//  ViewController.swift
//  MilageTracker
//
//  Created by Uday on 25/08/21.
//

import UIKit
import FirebaseAnalytics
import CoreMotion

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var activityStatusLabel: UILabel!
    @IBOutlet weak var stepCounterLabel: UILabel!
    
    //MARK: Constants:-
    let activityManager = CMMotionActivityManager()
    let padoMeter = CMPedometer()

    //MARK:-LifeCycle:-
    override func viewDidLoad() {
        super.viewDidLoad()
//        Analytics.logEvent("AppStart", parameters: [:])
        setUpActivityManager()
        setUpStepCounter()
    }
    
    
    /// start tracking activity if feature is available in current device
    func setUpActivityManager(){
        if CMMotionActivityManager.isActivityAvailable(){
            self.activityManager.startActivityUpdates(to: .main) { data in
                DispatchQueue.main.async {
                    if let activity = data{
                        if activity.running{
                            self.activityStatusLabel.text = "Running"
                            print("Runnnnnning")
                        }else if activity.stationary{
                            self.activityStatusLabel.text = "Stoped"
                            print("Stoped")
                        }else if activity.walking{
                            self.activityStatusLabel.text = "walking"
                            print("walking")
                        }else if activity.automotive{
                            self.activityStatusLabel.text = "Automobile"
                            print("Automobile")
                        }
                    }
                }
            }
        }
    }
    
    /// start step counting if feature is available in current device
    func setUpStepCounter(){
        if CMPedometer.isStepCountingAvailable(){
            self.padoMeter.startUpdates(from: Date()) { Data, Error in
                if Error != nil{
                   //error handling
                    print(Error?.localizedDescription as Any)
                }
                if let response = Data{
                    DispatchQueue.main.async {
                        self.stepCounterLabel.text = "Steps: \(response.numberOfSteps)"
                    }
                }
            }
        }
    } 
}

