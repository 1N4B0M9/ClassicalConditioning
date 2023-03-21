//
//  HealthKitManager.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/20/23.
//

import Foundation
import UIKit
import HealthKit
func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
    
}
class HealthKitManager:NSObject, ObservableObject {
    var isActive = false
    let healthStore = HKHealthStore()
   // func authorizeHealthKit() -> Bool {
        //var isEnabled = true
       // if HKHealthStore.isHealthDataAvailable() {
            
        //}
    //}
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
          return
        }
        guard   let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
                let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
                let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
                let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
                let height = HKObjectType.quantityType(forIdentifier: .height),
                let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
                let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
                
              //  completion(false, HealthkitSetupError.dataTypeNotAvailable)
                return
        }
        let healthKitTypesToWrite: Set<HKSampleType> = [bodyMassIndex,
                                                        activeEnergy,
                                                        HKObjectType.workoutType()]
            
        let healthKitTypesToRead: Set<HKObjectType> = [dateOfBirth,
                                                       bloodType,
                                                       biologicalSex,
                                                       bodyMassIndex,
                                                       height,
                                                       bodyMass,
                                                       HKObjectType.workoutType()]
        //4. Request Authorization
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite,
                                             read: healthKitTypesToRead) { (success, error) in
          completion(success, error)
        }
    }
    /*
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
    */
}

