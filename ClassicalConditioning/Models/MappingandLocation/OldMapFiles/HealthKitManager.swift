//
//  HealthKitManager.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/20/23.
//

import Foundation
import UIKit
import HealthKit
import CoreLocation
class HealthKitManager:NSObject, ObservableObject {
    var isActive = false
    let healthStore = HKHealthStore()
    var workouts : [HKWorkout] = []
    var routeBuilder = HKWorkoutRouteBuilder(healthStore: HKHealthStore(), device: nil)
    var start : Date = Date()
    var end : Date = Date()

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
                let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)
                    
            else {
                
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
    func Started(){
        start = Date()
    }
    func Ended(){
        end = Date()
    }
    func getWorkout(){
        
        workouts.append(HKWorkout(activityType: .running, start: start, end: end))
    }
            /*
            let runningObjectQuery = HKQuery.predicateForObjects(from:             workouts[workouts.count-1])
            let routeQuery = HKAnchoredObjectQuery(type: HKSeriesType.workoutRoute(), predicate: runningObjectQuery, anchor: nil, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, anchor, error) in
                                                                     
            guard error == nil else {
                // Handle any errors here.
                fatalError("The initial query failed.")
                }
                                                                     
        // Process the initial route data here.
        }
            routeQuery.updateHandler = { (query, samples, deleted, anchor, error) in
                
                guard error == nil else {
                    // Handle any errors here.
                    fatalError("The update failed.")
                }
                
                // Process updates or additions here.
            }

            self.healthStore.execute(routeQuery)


            
        }
             */
        
    
        func HKlocationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            //   let routeBuilder : HKWorkoutRouteBuilder =

            // Filter the raw data.
            let filteredLocations = locations.filter { (location: CLLocation) -> Bool in
                location.horizontalAccuracy <= 50.0
            }
            
            guard !filteredLocations.isEmpty else { return }
            
            // Add the filtered data to the route.
            routeBuilder.insertRouteData(filteredLocations) { (success, error) in
                if !success {
                    // Handle any errors here.
                }
            }
            
        }
    func endWorkout(){
        routeBuilder.finishRoute(with: workouts[workouts.count], metadata: nil) { (newRoute, error) in
            
            guard newRoute != nil else {
                // Handle any errors here.
                return
            }
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

