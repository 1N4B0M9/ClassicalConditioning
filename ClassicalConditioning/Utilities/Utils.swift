//
//  Utils.swift
//  ClassicalConditioning
//
//  Created by Ethan Lieberman (student LM) on 3/2/23.
//

import Foundation
import SwiftUI

//convert binding of type Binding<T?> to type Binding<T>?
extension Binding {
    func convert<T>(_ fallback: T) -> Binding<T> where Value == T? {
        return Binding<T> {
            self.wrappedValue == nil ? fallback : self.wrappedValue!
        } set: {
            self.wrappedValue = $0
        }
    }
}

//allow bindings to be used in string interpolation
extension String.StringInterpolation {
    mutating func appendInterpolation<T>(_ value: Binding<T?>) {
        appendInterpolation(value.wrappedValue == nil ? "nil" : "\(value.wrappedValue!)")
    }
}
