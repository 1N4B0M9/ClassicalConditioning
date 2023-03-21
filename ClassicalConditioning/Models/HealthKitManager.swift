//
//  HealthKitManager.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/20/23.
//

import Foundation
import UIKit
import HealthKit
class HealthKitManager:NSObject, ObservableObject {
    var isActive = false
    let healthStore = HKHealthStore()
   // func authorizeHealthKit() -> Bool {
        //var isEnabled = true
       // if HKHealthStore.isHealthDataAvailable() {
            
        //}
    //}
    
    func requestAccess() -> Bool{
        var ok = false
        let allTypes = Set([HKObjectType.workoutType(),
                            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
                            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                            HKObjectType.quantityType(forIdentifier: .heartRate)!,
                            HKObjectType.quantityType(forIdentifier: .dietaryVitaminK)!])
        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if success {
                ok = true
                self.isActive = true

            }
            else {
                ok = false
            }
            
        }
        return ok

    }
    func getWalk(){
        print(HKObjectType.characteristicType(forIdentifier: .dateOfBirth) ?? "not born")
    }
}

