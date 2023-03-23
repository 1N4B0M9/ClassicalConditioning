//
//  HealthKitTestView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/22/23.
//

import SwiftUI

struct HealthKitTestView: View {
    var he : HealthKitManager = HealthKitManager()
    var body: some View {
        Button {
        he.authorizeHealthKit { (authorized, error) in
              
          guard authorized else {
                
            let baseMessage = "HealthKit Authorization Failed"
                
            if let error = error {
              print("\(baseMessage). Reason: \(error.localizedDescription)")
            } else {
              print(baseMessage)
            }
                
            return
          }
              
          print("HealthKit Successfully Authorized.")
        }
        
        } label: {
            Text("Verify")
        }
        Button {
            he.Started()
        } label : {
            Text("Start Workout")
            
        }
        Button {
            he.Ended()
            he.endWorkout()
            he.getWorkout()
            
        } label : {
            Text("Start Workout")
            
        }
        
    }
}

struct HealthKitTestView_Previews: PreviewProvider {
    static var previews: some View {
        HealthKitTestView()
    }
}
