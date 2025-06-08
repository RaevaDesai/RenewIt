//
//  PinnedLocation.swift
//  RenewIt
//
//  Created by Raeva Desai on 6/8/25.
//

import Foundation
import SwiftUI
import MapKit

struct PinnedLocation: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    let openHours: String
    let description: String
    var distanceFromUser: Double? = nil
}

let sampleFRCLabs: [PinnedLocation] = [
    PinnedLocation(
        name: "SJSU Robotics, Sensors & Machine Intelligence Lab",
        address: "San José State University, One Washington Square, San Jose, CA 95192",
        coordinate: CLLocationCoordinate2D(latitude: 37.3352, longitude: -121.8811),
        openHours: "By appointment (check website)",
        description: "SJSU’s RSMI Lab works on robotics and smart devices. May accept donations for educational projects."
    ),
    PinnedLocation(
        name: "RobotLAB San Jose",
        address: "San Jose, CA (Contact for address)",
        coordinate: CLLocationCoordinate2D(latitude: 37.3382, longitude: -121.8863), // Downtown SJ
        openHours: "Mon-Fri: 9am-5pm",
        description: "Provides robotics solutions and may accept donations or offer recycling advice."
    )
]

let sampleRecyclingCenters: [PinnedLocation] = [
    PinnedLocation(
        name: "GreenWaste Recycling Facility",
        address: "705 Los Esteros Road, San Jose, CA 95134",
        coordinate: CLLocationCoordinate2D(latitude: 37.4225, longitude: -121.9649),
        openHours: "Mon-Fri: 6am-5:45pm, Sat-Sun: 8am-3:45pm",
        description: "Accepts construction, demolition, and bulky item recycling."
    ),
    PinnedLocation(
        name: "GreenWaste Recycling Facility (Site 2)",
        address: "675 Los Esteros Road, San Jose, CA 95134",
        coordinate: CLLocationCoordinate2D(latitude: 37.4223, longitude: -121.9647),
        openHours: "Mon-Fri: 6am-4:45pm, Sat-Sun: Closed",
        description: "Recycling for construction and bulky items."
    )
]

let sampleCharities: [PinnedLocation] = [
    PinnedLocation(
        name: "Goodwill of Silicon Valley",
        address: "1691 West San Carlos St, San Jose, CA 95128",
        coordinate: CLLocationCoordinate2D(latitude: 37.3275, longitude: -121.9324),
        openHours: "10:00am-8:00pm (Donation hours may vary)",
        description: "Accepts clothing, shoes, accessories, household items, and furniture."
    ),
    PinnedLocation(
        name: "Black and Brown Thrift Store",
        address: "751 West San Carlos Street, San Jose, CA 95126",
        coordinate: CLLocationCoordinate2D(latitude: 37.3286, longitude: -121.9072),
        openHours: "Check Instagram for hours",
        description: "Consignment store for modern, designer, and vintage clothes."
    ),
    PinnedLocation(
        name: "American Cancer Society Discovery Shop",
        address: "1103 Branham Lane, San Jose, CA 95118",
        coordinate: CLLocationCoordinate2D(latitude: 37.2555, longitude: -121.8596),
        openHours: "Check website for hours",
        description: "Thrift store supporting cancer research."
    ),
    PinnedLocation(
        name: "Crossroads Trading Co.",
        address: "1959 West San Carlos Street, San Jose, CA 95128",
        coordinate: CLLocationCoordinate2D(latitude: 37.3288, longitude: -121.9403),
        openHours: "11:00am-7:00pm",
        description: "Large thrift spot with many clothing options."
    ),
    PinnedLocation(
        name: "Moon Zooom",
        address: "1630 West San Carlos Street, San Jose, CA 95128",
        coordinate: CLLocationCoordinate2D(latitude: 37.3289, longitude: -121.9361),
        openHours: "Check Instagram for hours",
        description: "Vintage clothing and collectibles."
    ),
    PinnedLocation(
        name: "Classic Loot",
        address: "570 North 6th Street, San Jose, CA 95112",
        coordinate: CLLocationCoordinate2D(latitude: 37.3472, longitude: -121.9006),
        openHours: "Check Instagram for hours",
        description: "Vintage and Y2K clothing and accessories."
    ),
    PinnedLocation(
        name: "Teen Challenge South Bay Thrift Store",
        address: "1897 West San Carlos Street, San Jose, CA 95128",
        coordinate: CLLocationCoordinate2D(latitude: 37.3295, longitude: -121.9489),
        openHours: "Check website for hours",
        description: "Clothing, shoes, accessories, books, collectibles, and furniture."
    ),
    PinnedLocation(
        name: "Sacred Heart Community Service Donation Station",
        address: "1381 South 1st Street, San Jose, CA 95110",
        coordinate: CLLocationCoordinate2D(latitude: 37.3280, longitude: -121.8720),
        openHours: "Check website for hours",
        description: "Accepts clothing, food, and household donations."
    )
]

let allPins: [PinnedLocation] = sampleFRCLabs + sampleRecyclingCenters + sampleCharities
