//
//  RandomAccessCollection+Indexed.swift
//  TopSpin
//
//  Created by Will Brandin on 10/8/20.
//

import Foundation

extension RandomAccessCollection {
    func indexed() -> Array<(offset: Int, element: Element)> {
        Array(enumerated())
    }
}
