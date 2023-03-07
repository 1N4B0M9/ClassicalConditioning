//
//  Utils.swift
//  ClassicalConditioning
//
//  Created by Ethan Lieberman (student LM) on 3/2/23.
//

import Foundation
import SwiftUI

//allow bindings to be used in string interpolation
extension String.StringInterpolation {
    public mutating func appendInterpolation(_ binding: Binding<Int?>) {
        //appendLiteral(binding == nil || binding!.wrappedValue == nil ? "nil" : String(describing: binding!.wrappedValue!))
        appendLiteral("\(binding.wrappedValue == nil ? "nil" : String(describing: binding.wrappedValue!))")
    }
}

//convert binding of type Binding<T?> to type Binding<T>?
extension Binding: CustomStringConvertible {
    public var description: String {
        String(describing: self.wrappedValue)
    }
    
    func convert<T>() -> Binding<T>? where Value == T? {
        guard let wrapped = self.wrappedValue else {
            return nil
        }
        
        return Binding<T> {
            wrapped
        } set: {
            self.wrappedValue = $0
        }
    }
}
