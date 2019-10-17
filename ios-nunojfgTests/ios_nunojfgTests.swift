//
//  ios_nunojfgTests.swift
//  ios-nunojfgTests
//
//  Created by Nuno Gonçalves on 18/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ios_nunojfg

class ios_nunojfgTests: XCTestCase {
    
    let location = CLLocation(
                latitude: CLLocationDegrees(exactly: 51.50853)!,
                longitude: CLLocationDegrees(exactly: -0.12574)!)
    let apiClient = APIClient()
    
    func loadJson(filename fileName: String) -> ForecastDTO? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ForecastDTO.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDTOs(filename: String) {
        
        let forecastDTO = loadJson(filename: "forecast")
        
        XCTAssertNotNil(forecastDTO)
        
        let forecasListDTO = forecastDTO?.list
        
        XCTAssertNotNil(forecasListDTO)
        XCTAssertNotNil(forecasListDTO?.first)
    }
    
    func testDTOsForBrokenJson() {
        
        let forecastDTO = loadJson(filename: "forecast_broken")
        
        XCTAssertNil(forecastDTO)
        
        let forecasListDTO = forecastDTO?.list
        
        XCTAssertNil(forecasListDTO)
        XCTAssertNil(forecasListDTO?.first)
    }
    
    func testDTOsForLiveData() {
        
        apiClient.getForecast(location: self.location, completion: { (forecastDTO: ForecastDTO) in
            XCTAssertNotNil(forecastDTO)
            
            let forecasListDTO = forecastDTO.list
            
            XCTAssertNotNil(forecasListDTO)
            XCTAssertNotNil(forecasListDTO?.first)
        })
    }
    
    func testViewModels(forecastDTO: ForecastDTO) {
        
        guard let testableDTO = forecastDTO.list?.first else {
            return
        }
        
        let viewModel = ForecastFactory.build(from: testableDTO)
        
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.values.summary.temperature, 18.55)
        XCTAssertEqual(viewModel.values.summary.timeOfDay, Date(timeIntervalSince1970: TimeInterval(1534971600)))
        XCTAssertNotNil(viewModel.values.summary.weatherIconURL)
    }
    
    func testViewModelsForMockedData() {
        
        guard let forecastDTO = loadJson(filename: "forecast") else {
            return
        }
        
        testViewModels(forecastDTO: forecastDTO)
    }
    
    func testViewModelsForLiveData() {
        
        apiClient.getForecast(location: self.location, completion: { (forecastDTO: ForecastDTO) in
            self.testViewModels(forecastDTO: forecastDTO)
        })
    }
    
    func testPerformanceExample() {
        
        self.measure {
            apiClient.getForecast(location: self.location, completion: { (dto: ForecastDTO) in
                
            })
        }
    }
    
}
