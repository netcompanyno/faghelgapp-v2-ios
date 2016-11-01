//
//  Event.swift
//  Faghelgapp
//
//  Created by Anders Ullnæss on 03/10/16.
//  Copyright © 2016 Idar Vassdal. All rights reserved.
//

import Foundation

class Event {
    var start: Date
    var end: Date
    var desc: String?
    var title: String?
    var hostNames: String?
    var eventImageUrl: String?
    var responsible: Person?
    var speakers: [Person]?
    
    init(start: Date, end: Date, desc: String?, title: String?, hostNames: String?, eventImageUrl: String?, responsible: Person?, speakers: [Person]?) {
        self.start = start
        self.end = end
        self.desc = desc
        self.title = title
        self.hostNames = hostNames
        self.eventImageUrl = eventImageUrl
        self.responsible = responsible
        self.speakers = speakers
    }
    
    class func from(json: [String: Any]) -> Event {
        let startTime = json["start"] as! Double
        let start = Date(timeIntervalSince1970: startTime)
        let endTime = json["end"] as! Double
        let end = Date(timeIntervalSince1970: endTime)
        let title = json["title"] as? String
        let eventImageUrl = json["eventImageUrl"] as? String
        let desc = json["description"] as? String
        let hostNames = json["hostNames"] as? String
        var speakers = [Person]()
        if let speakersDict = json["speakers"] as? [String: Any] {
            // TODO:
            // Add persons
            
        }
        
        // Remove when adding persons above
        for i in 1...3{
            speakers.append(Person(shortName: "Person\(i)", fullName: "Person \(i)", profileImageUrl: "image"))
        }
        
        var responsible: Person?
        if let responsibleDict = json["responsible"] as? [String: Any] {
            responsible = Person.from(responsibleDict)
        }
        
        let event = Event(start: start, end: end, desc: desc, title: title, hostNames: hostNames, eventImageUrl: eventImageUrl, responsible: responsible, speakers: speakers)
        
        return event
    }
    
}
