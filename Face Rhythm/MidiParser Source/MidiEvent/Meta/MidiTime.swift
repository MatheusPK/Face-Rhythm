//
//  struct.swift
//  MidiParser iOS
//
//  Created by Vladimir Vybornov on 7/1/19.
//  Copyright © 2019 Yuma Matsune. All rights reserved.
//

import Foundation

public struct MidiTime {
    let inSeconds: TimeInterval
    let inTicks: Ticks
}

public extension MidiTime {
    static var empty: MidiTime {
        return MidiTime(inSeconds: 0.0, inTicks: Ticks(0))
    }
}

///Alteração no MidiParser
public extension MidiTime{
    func getTimeInSeconds() -> TimeInterval{
        return self.inSeconds
    }
}

