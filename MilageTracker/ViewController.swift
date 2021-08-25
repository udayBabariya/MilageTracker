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
    
    //MARK: Constants:-
    let activityManager = CMMotionActivityManager()
    let padoMeter = CMPedometer()

    //MARK:-LifeCycle:-
    override func viewDidLoad() {
        super.viewDidLoad()
//        Analytics.logEvent("AppStart", parameters: [:])
        setUpActivityManager()
    }
    
    
    /// start tracking activity if feature is available
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


}

