import UIKit

var str = "Hello, playground"


//Documents directory
let fileManager = FileManager.default
let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//Create a file name
let location = documentsDir.appendingPathComponent("star.plist")
print(location.path)

//Save to disk

struct Star: Codable {
    var name: String
    var distance: Double
}

let star = Star(name: "Proxima Centauri", distance: 4.24)

let encoder = PropertyListEncoder()
do {
    let data = try encoder.encode(star)
    print(data)
    print(data as NSData)
    try data.write(to: location)
} catch {
    print("Error saving to disk: \(error)")
}

//Load from disk

let decoder = PropertyListDecoder()

do {
    let data = try Data(contentsOf: location)
    let loadedStar = try decoder.decode(Star.self, from: data)
    print("Star: \(loadedStar)")
} catch {
    print("Error loading from disk: \(error)")
}

//inspect finder/terminal


