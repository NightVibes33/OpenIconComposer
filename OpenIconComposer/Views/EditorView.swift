import SwiftUI

struct EditorView: View {
    @State private var scene = IconScene(layers: [
        MaterialLayer(name: "Background", type: .solid, color: .blue, depth: -1.0),
        MaterialLayer(name: "Glass Overlay", type: .softGlass, color: ColorData(r: 1, g: 1, b: 1, a: 0.2), depth: 0.5)
    ])
    
    var body: some View {
        NavigationView {
            HStack(spacing: 0) {
                LayerStackPanel(layers: $scene.layers)
                    .frame(width: 250)
                
                CanvasView(layers: scene.layers)
                    .layoutPriority(1)
                
                MaterialInspectorPanel(layer: $scene.layers[0]) // Simplification for template
                    .frame(width: 300)
            }
            .navigationTitle("Open Icon Composer")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LayerStackPanel: View {
    @Binding var layers: [MaterialLayer]
    var body: some View {
        List {
            ForEach(layers) { layer in
                Text(layer.name)
            }
        }
    }
}

struct MaterialInspectorPanel: View {
    @Binding var layer: MaterialLayer
    var body: some View {
        Form {
            Section("Material") {
                Picker("Type", selection: $layer.type) {
                    ForEach(MaterialType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                Slider(value: $layer.depth, in: -1.0...1.5) { Text("Depth") }
            }
        }
    }
}

struct CanvasView: View {
    var layers: [MaterialLayer]
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            // Icon Container
            ZStack {
                ForEach(layers) { layer in
                    if layer.isVisible {
                        IconLayerNode(layer: layer)
                    }
                }
            }
            .frame(width: 512, height: 512)
            .clipShape(RoundedRectangle(cornerRadius: 114))
            .shadow(radius: 20)
        }
    }
}

struct IconLayerNode: View {
    var layer: MaterialLayer
    var body: some View {
        Rectangle()
            .fill(Color(red: layer.color.r, green: layer.color.g, blue: layer.color.b).opacity(layer.opacity))
            .blur(radius: CGFloat(layer.blurRadius))
            .offset(x: layer.offset.x, y: layer.offset.y)
            .scaleEffect(CGFloat(layer.scale))
            .rotationEffect(.degrees(layer.rotation))
    }
}
