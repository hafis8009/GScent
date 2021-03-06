//
//  DashboardNetworkAdapterTests.swift
//  GScentTests
//
//  Created by AdibUser on 06/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import GScent

class DashboardNetworkAdapterTests: QuickSpec {
    var endpointModel: NetworkEndpointModel?
    var networkClient: NetworkClient?
    var networkAdapter: DashboardNetworkAdapter?
    
    override func spec() {
        describe("DashboardNetworkAdapter Tests") {
            context("When invalid data received in the network call") {
                beforeEach {
                    self.endpointModel = NetworkEndpointModel(baseUrl: "http://google.com", path: "app", offlineFileName: "notExisting")
                    self.networkClient = NetworkClient(endpoint: self.endpointModel!)
                    self.networkAdapter = DashboardNetworkAdapter(networkClient: self.networkClient!)
                }
                
                it("Should return error") {
                    self.networkAdapter?.getDashboardItems() { models, error in
                        expect(error).toNot(beNil())
                    }
                }
                
                it("Should return nil result") {
                    self.networkAdapter?.getDashboardItems() { models, error in
                        expect(models).to(beNil())
                    }
                }
            }
            
            context("When valid data received in the network call") {
                beforeEach {
                    self.endpointModel = NetworkEndpointModel(baseUrl: "http://google.com", path: "app", offlineFileName: "dashboardItems")
                    self.networkClient = NetworkClient(endpoint: self.endpointModel!)
                    self.networkAdapter = DashboardNetworkAdapter(networkClient: self.networkClient!)
                }

                it("Should not return error") {
                    self.networkAdapter?.getDashboardItems() { models, error in
                        expect(error).to(beNil())
                    }
                }
                
                it("Should return valid parsed models") {
                    self.networkAdapter?.getDashboardItems() { result, error in
                        expect(result).toNot(beNil())
                        let models = result!
                        
                        expect(models.count == 6).to(beTrue())
                        expect(models[0].rowType == .image).to(beTrue())
                        expect(models[1].rowType == .customSlider).to(beTrue())
                        expect(models[2].rowType == .image).to(beTrue())
                        expect(models[3].rowType == .text).to(beTrue())
                        expect(models[4].rowType == .image).to(beTrue())
                        expect(models[5].rowType == .text).to(beTrue())
                    }
                }
            }
        }
    }
}
