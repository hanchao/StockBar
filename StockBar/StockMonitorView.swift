//
//  NetworkMonitorView.swift
//  Network Monitor Status Bar
//
//  Created by David Falconer on 7/2/18.
//  Copyright © 2018 David Falconer. All rights reserved.
//

import Foundation
import Cocoa

class ShockMonitorView: NSView {
    private let kilobyte:Double = 1024
    private let megabyte:Double = 1024*1024
    private let gigabyte:Double = 1024*1024*1024
    
    var stockVaule:String = "0"
    var stockRate:String = "0"
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // RECTs we will be drawing in
        let rectStockVaule = NSMakeRect(2, 11, 56, 11)
        let rectStockRate = NSMakeRect(2, 1, 56, 11)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .right
        
        // Font display attributes
        let isDark = NSAppearance.current.name.rawValue.hasPrefix("NSAppearanceNameVibrantDark")

        let fontAttributes = [
            NSAttributedString.Key.font              : NSFont.monospacedDigitSystemFont(ofSize: 10.0, weight: NSFont.Weight.medium),
            NSAttributedString.Key.foregroundColor   : isDark ? NSColor.white : NSColor.black,
            NSAttributedString.Key.paragraphStyle    : paragraph
        ]

        // Finally, draw!
        let stockVauleReadable:NSString = stockVaule as NSString;
        let stockRateReadable:NSString = stockRate as NSString;
        stockVauleReadable.draw(in: rectStockVaule, withAttributes: fontAttributes)
        stockRateReadable.draw(in: rectStockRate, withAttributes: fontAttributes)
    }
}
