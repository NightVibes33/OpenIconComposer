import SwiftUI

enum MaterialType: String, Codable, CaseIterable {
    case solid = "Solid"
    case softGlass = "Soft Glass"
    case hardGlass = "Hard Glass"
    case frostedGlass = "Frosted Glass"
    case emissive = "Emissive"
}

struct MaterialLayer: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: MaterialType
    var color: ColorData
    var opacity: Double = 1.0
    var depth: Double = 0.0 // -1.0 to 1.5
    var blurRadius: Double = 10.0
    var refractionFactor: Double = 0.5
    var isVisible: Bool = true
    var isLocked: Bool = false
    var offset: CGPoint = .zero
    var scale: Double = 1.0
    var rotation: Double = 0.0
}

struct ColorData: Codable {
    var r: Double
    var g: Double
    var b: Double
    var a: Double
    
    static var blue = ColorData(r: 0, g: 0.48, b: 1, a: 1)
}

struct IconScene: Codable {
    var layers: [MaterialLayer] = []
}
