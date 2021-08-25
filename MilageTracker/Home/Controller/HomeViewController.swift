//
//  HomeViewController.swift
//  MilageTracker
//
//  Created by Uday on 25/08/21.
//

import UIKit
import FirebaseAnalytics

class HomeViewController: UIViewController{
    
    
    //MARK: Outlets
    @IBOutlet weak var activityStatusLabel: UILabel!
    @IBOutlet weak var stepCounterLabel: UILabel!
    
    //MARK: Constants/var:-
    var viewModel: HomeViewModel?

    //MARK:-LifeCycle:-
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.logEvent("AppStart", parameters: nil)
        viewModel = HomeViewModel()
        viewModel?.startActivityManager(handler: { status in
            self.activityStatusLabel.text = "User activity Status: \(status.value)"
        })
        
        viewModel?.startStepCounter(handler: { data in
            self.stepCounterLabel.text = "Total steps: \(data.numberOfSteps)"
        })
    }
    
    
   
}
