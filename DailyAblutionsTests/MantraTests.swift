//
//  DailyAblutionsTests.swift
//  DailyAblutionsTests
//
//  Created by Derek Noble on 4/13/20.
//  Copyright © 2020 Noble Software. All rights reserved.
//

import XCTest
import UserNotifications
@testable import DailyAblutions

class MantraTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEquality() throws {
        let standardId: UInt = 1
        let ignoreTitle = "Black Sheep Wall"
        let ignoreText = "Not a complete."
        
        let standardMantra = Mantra(id: standardId, title: ignoreTitle, text: ignoreText)
        
        //same ids should be equal
        let identicalControlMantra = Mantra(id: standardId, title: ignoreTitle, text: ignoreText)
        XCTAssertEqual(standardMantra, identicalControlMantra)
        
        //differing ids should be unequal
        let differentIdControlMantra = Mantra(id: 2, title: ignoreTitle, text: ignoreText)
        XCTAssertNotEqual(standardMantra, differentIdControlMantra)
    }
    
    func testInits() throws {
        //init() creates a Mantra with the following fields:
        let basicMantra = Mantra(id: 0, title: "", text: "")
        let basicTestMantra = Mantra()
        XCTAssertTrue(Mantra.InstancesHaveEqualFields(basicTestMantra, basicMantra))
        
        
        //init(id:, text:) sets the id and text by parameter and viewedToday as false
        let customId: UInt = 3
        let customTitle = "Identity"
        let customText = "You are a woke Deaf person"
        let customTestMantra = Mantra(id: customId, title: customTitle, text: customText)
        let customMantra = Mantra(id: customId, title: customTitle, text: customText)
        XCTAssertTrue(Mantra.InstancesHaveEqualFields(customTestMantra, customMantra))
        
        let differentId: UInt = 5
        let differentIdMantra = Mantra(id: differentId, title: customTitle, text: customText)
        XCTAssertFalse(Mantra.InstancesHaveEqualFields(customTestMantra, differentIdMantra))
        
        let differentTitle = "Non Identity"
        let differentTitleMantra = Mantra(id: customId, title: differentTitle, text: customText)
        XCTAssertFalse(Mantra.InstancesHaveEqualFields(customTestMantra, differentTitleMantra))
        
        let differentText = "I HAVE THE PANTS"
        let differentTextMantra = Mantra(id: customId, title: customTitle, text: differentText)
        XCTAssertFalse(Mantra.InstancesHaveEqualFields(customTestMantra, differentTextMantra))
        
        let differentIdTitleTextMantra = Mantra(id: differentId, title: differentTitle, text: differentText)
        XCTAssertFalse(Mantra.InstancesHaveEqualFields(customMantra, differentIdTitleTextMantra))
        
        
        //init?(coder: ) sets the id and text by file and viewedToday as false
        let sampleData: [String: Codable] = [Mantra.PropertyKeys.ID: 3, Mantra.PropertyKeys.TEXT: "Not a complete."]
        /*
         //Write the sample data to the TestDataContainer file
        TestUtilities.WriteToTestDataContainer([sampleData])
         //Initialize a new Mantra from the file
         //Mock a test Mantra with the same id and text
         //Assert that the Mantras have equal fields
         
         //same song and dance as above
        */
    }
    
    func testChangeText() throws {
        //overwrites the text
        let newText = "This is awkward."
        let editingMantra = Mantra(id: 0, title: "", text: "Well then")
        editingMantra.ChangeText(to: newText)
        XCTAssertEqual(editingMantra.m_Text, newText)
    }
    
    func testChangeTitle() throws {
        //overwrites the title
        let newTitle = "Banana"
        let editingMantra = Mantra(id: 0, title: "Something Profound", text: "")
        editingMantra.ChangeTitle(to: newTitle)
        XCTAssertEqual(editingMantra.m_Title, newTitle)
    }
    
    func testDescription() throws {
        //description shows the mantra's properties in an organized format
        let mantra = Mantra(id: 2, title: "Remember", text: "Not a complete.")
        XCTAssertEqual(mantra.description, "\nId: 2\nTitle: Remember\nText: Not a complete.")
    }
    
    func testNotificationContent() throws {
        let id: UInt = 1
        let title = NSString.localizedUserNotificationString(forKey: "Persuasion", arguments: nil)
        let text = NSString.localizedUserNotificationString(forKey: "Your environment shapes your behavior.", arguments: nil)
        
        let mantra = Mantra(id: id, title: title, text: text)
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = text
        content.sound = UNNotificationSound.default
        XCTAssertTrue(content == mantra.notificationContent)
    }
    
    func testHash() throws {
        //hashing combines the text, id, and ViewedToday properties
        let id: UInt = 1
        let title = "Road Trip"
        let text = "Not a complete."
        let mantra = Mantra(id: id, title: title, text: text)
        
        var mantraHasher = Hasher()
        mantra.hash(into: &mantraHasher)
        
        var manualHasher = Hasher()
        manualHasher.combine(id)
        manualHasher.combine(title)
        manualHasher.combine(text)
        
        XCTAssertEqual(manualHasher.finalize(), mantraHasher.finalize())
    }
    
    func testEncode() throws {
        //encoding includes only the id and text properties
        let id: UInt = 1
        let title = "Road Trip"
        let text = "Not a complete."
        let mantra = Mantra(id: id, title: title, text: text)
        
        let mantraEncoder = NSKeyedArchiver(requiringSecureCoding: true)
        mantra.encode(with: mantraEncoder)
        mantraEncoder.finishEncoding()
        
        let manualEncoder = NSKeyedArchiver(requiringSecureCoding: true)
        manualEncoder.encode(id, forKey: Mantra.CodingKeys.id.rawValue)
        manualEncoder.encode(title, forKey: Mantra.CodingKeys.title.rawValue)
        manualEncoder.encode(text, forKey: Mantra.CodingKeys.text.rawValue)
        manualEncoder.finishEncoding()
        
        XCTAssertEqual(mantraEncoder.encodedData, manualEncoder.encodedData)
    }
}
