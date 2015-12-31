//
//  Helpers.swift
//  FootPrint
//
//  Created by Chang Tong Xue on 2015-12-25.
//  Copyright © 2015 DX. All rights reserved.
//

import Foundation

let defaultCategories = ["Favorite", "Restaurant", "Public library", "Bus Stop", "School", "Airport", "Bank", "Bar", "Beach", "Camping", "Drink Place", "Hospital", "Shopping Mall",
    "Market", "Museum", "Shop", "Skytrain", "Uncategorized", "Visited Place", "WiFi HotSpot",
    "Wonderland", "Place Marker"
]

func getIconImage(category: String) -> String {
    
    switch(category) {
    case defaultCategories[0]:
        return  "favorite"
    case defaultCategories[1]:
        return "restaurant"
    case defaultCategories[2]:
        return "library"
    case defaultCategories[3]:
        return "bus"
    case defaultCategories[4]:
        return"school"
    case defaultCategories[5]:
        return "airport"
    case defaultCategories[6]:
        return "bank"
    case defaultCategories[7]:
        return "bar"
    case defaultCategories[8]:
        return "beach"
    case defaultCategories[9]:
        return "camp"
    case defaultCategories[10]:
        return "drink"
    case defaultCategories[11]:
        return "hospital"
    case defaultCategories[12]:
        return "mall"
    case defaultCategories[13]:
        return "market"
    case defaultCategories[14]:
        return "museum"
    case defaultCategories[15]:
        return "shop"
    case defaultCategories[16]:
        return "skytrain"
    case defaultCategories[17]:
        return "uncat"
    case defaultCategories[18]:
        return "visit"
    case defaultCategories[19]:
        return "wifi"
    case defaultCategories[20]:
        return "wonderland"
    case defaultCategories[21]:
        return "marker"
    default:
        return "uncat"
    }
}
