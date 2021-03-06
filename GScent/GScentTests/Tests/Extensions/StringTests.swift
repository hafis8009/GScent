//
//  StringTests.swift
//  GScentTests
//
//  Created by AdibUser on 06/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import GScent

class StringTests: QuickSpec {
    var testString: String = ""
    
    override func spec() {
        describe("String Extension") {
            context("URL util") {
                context("When it contains a valid url text") {
                    beforeEach {
                        self.testString = "http://google.com"
                    }
                    
                    it("should give a valid URL object") {
                        expect(self.testString.asURL != nil).to(beTrue())
                        expect(self.testString.asURL!.absoluteString == "http://google.com").to(beTrue())
                    }
                }
                
                context("When it does not contains a valid url text") {
                    beforeEach {
                        self.testString = "hello world"
                    }
                    
                    it("should give a valid URL object") {
                        expect(self.testString.asURL == nil).to(beTrue())
                    }
                }
            }
            
            context("Pixel util") {
                context("When it contains a valid pixel text") {
                    beforeEach {
                        self.testString = "12px"
                    }
                    
                    it("should give a valid pixel value") {
                        expect(self.testString.pixelValue == 12).to(beTrue())
                    }
                }
                
                context("When it contains an invalid pixel text") {
                    it("should give 0.0 as pixel Int value") {
                        self.testString = "12xx"
                        expect(self.testString.pixelValue == 0.0).to(beTrue())
                        
                        self.testString = "hello"
                        expect(self.testString.pixelValue == 0.0).to(beTrue())
                    }
                }
            }
            
            context("TextAlignment util") {
                context("When it contains a valid alignment text") {
                    it("should give a valid alignment value") {
                        self.testString = "left"
                        expect(self.testString.asTextAlignment! == .left).to(beTrue())
                        
                        self.testString = "right"
                        expect(self.testString.asTextAlignment! == .right).to(beTrue())
                        
                        self.testString = "center"
                        expect(self.testString.asTextAlignment! == .center).to(beTrue())
                    }
                }
                
                context("When it contains an invalid alignment text") {
                    it("should give null value") {
                        self.testString = "junk"
                        expect(self.testString.asTextAlignment == nil).to(beTrue())
                    }
                }
            }
            
            context("Color util") {
                context("When it contains a valid hex color text") {
                    it("should give a valid color object") {
                        self.testString = "#FF0000"
                        expect(self.testString.asColor! == .red).to(beTrue())
                        
                        self.testString = "#00FF00FF"
                        expect(self.testString.asColor! == .green).to(beTrue())
                    }
                }
                
                context("When it contains an invalid hex color text") {
                    it("should give null value") {
                        self.testString = "junk"
                        expect(self.testString.asColor == nil).to(beTrue())
                        
                        self.testString = "000000"
                        expect(self.testString.asColor == nil).to(beTrue())
                    }
                }
            }
        }
    }
}
