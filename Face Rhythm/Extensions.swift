//
//  Extensions.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 26/01/21.
//

import Foundation


extension Dictionary where Value: Equatable{
    func getKeyByValue(value: Value) -> Key? {
        return (self.keys.filter{self[$0] == value}).first
    }
}
