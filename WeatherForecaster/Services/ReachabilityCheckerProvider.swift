//
//  ReachabilityCheckerProvider.swift
//  WeatherForecaster
//
//  Created by Anton on 20.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
class ReachabilityCheckerProvider: ReachabilityChecker {
    var reachability = Reachability()!
    var internetIsAvailable: Bool
    
    
    func startWatching() {
        addReachabilityWatcher()
    }
    
    func stopWatching() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    init() {
       self.internetIsAvailable = reachability.connection != .none
    }
    
}

extension ReachabilityCheckerProvider {
    private func addReachabilityWatcher() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            self.internetIsAvailable = true
        case .cellular:
            self.internetIsAvailable = true
        case .none:
            self.internetIsAvailable = false
        }
    }
}
