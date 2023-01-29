//
//  Generator.swift
//  Right on target
//
//  Created by macbook on 04.08.2022.
//

import UIKit

// MARK: - Protocols

protocol GeneratorProtocol {
    func getRandomValue() -> Int
    func getColor(_ rgbValue: Int) -> UIColor
}

// MARK: - Structures and Classes

struct Generator: GeneratorProtocol  {
    private var minValue: Int
    private var maxValue: Int
    
    init?(minValue: Int, maxValue: Int) {
        guard minValue <= maxValue else { return nil }
        
        self.minValue = minValue
        self.maxValue = maxValue
    }
    
    func getRandomValue() -> Int {
        (minValue...maxValue).randomElement() ?? 0
    }
    
    func getColor(_ rgbValue: Int) -> UIColor {
        return UIColor(red: CGFloat((Float((rgbValue & 0xff0000) >> 16)) / 255.0),
                             green: CGFloat((Float((rgbValue & 0x00ff00) >> 8)) / 255.0),
                             blue: CGFloat((Float((rgbValue & 0x0000ff) >> 0)) / 255.0),
                             alpha: 1)
    }
    
}

