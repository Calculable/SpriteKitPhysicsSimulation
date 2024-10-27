import SwiftUI
import SpriteKit
import UIKit

struct ContentView: View {

    @State private var scene = GameSceneWrapper()

    @State var resetOnNextUpdate: Bool = false

    @State var gravityX: Float = 0.0
    @State var gravityY: Float = 0.0

    @State var fillColor: Color = Color.blue
    @State var strokeColor: Color = Color.white
    @State var lineWidth: Float = 1.0
    @State var radius: Float = 10.0

    @State var affectedByGravity: Bool = true
    @State var isDynamic = true
    @State var allowsRotation = true
    @State var pinned = false
    @State var density: Float = 1.0
    @State var friction: CGFloat = 0.2
    @State var linearDamping: CGFloat = 0.1
    @State var restitution: CGFloat = 0.2

    @State var charge: CGFloat = 0.0
    @State var hasAMagneticField: Bool = false
    @State var magneticFieldStrenght: Int = 100

    @State var hasVelocity: Bool = false
    @State var velocityX: Int = 0
    @State var velocityY: Int = 0

    var body: some View {
        HStack {
            NavigationStack {
                VStack(spacing: 0) {
                    Form {
                        Section("Scene Gravity") {
                            LabeledContent {
                                TextField(value: $gravityX, format: .number) {
                                    Text("➡️ Gravity X")
                                }
                                .multilineTextAlignment(.trailing)
                            } label: {
                                Text("➡️ Gravity X")
                            }

                            LabeledContent {
                                TextField(value: $gravityY, format: .number) {
                                    Text("⬆️ Gravity Y")
                                }
                                .multilineTextAlignment(.trailing)
                            } label: {
                                Text("⬆️ Gravity Y")
                            }
                        }
                        Section("Templates") {
                            Button("Small Ball") {
                                fillColor = Color.blue
                                strokeColor = Color.white
                                lineWidth = 1
                                radius = 10
                                affectedByGravity = true
                                isDynamic = true
                                allowsRotation = true
                                pinned = false
                                density = 1
                                friction = 0.2
                                linearDamping = 0.1
                                restitution = 0.2
                                charge = -0.1
                                hasAMagneticField = false
                                hasVelocity = false
                                velocityX = 0
                                velocityY = 0
                            }

                            Button("Big Ball") {
                                fillColor = Color.red
                                strokeColor = Color.white
                                lineWidth = 4
                                radius = 40
                                affectedByGravity = true
                                isDynamic = true
                                allowsRotation = true
                                pinned = false
                                density = 1
                                friction = 0.2
                                linearDamping = 0.1
                                restitution = 0.2
                                charge = -0.1
                                hasAMagneticField = false
                                hasVelocity = false
                                velocityX = 0
                                velocityY = 0
                            }

                            Button("Magnetic Field") {
                                fillColor = Color.gray
                                strokeColor = Color.white
                                lineWidth = 4
                                radius = 40
                                affectedByGravity = false
                                isDynamic = false
                                allowsRotation = true
                                pinned = false
                                density = 1
                                friction = 0.2
                                linearDamping = 0.1
                                restitution = 0.2
                                hasAMagneticField = true
                                magneticFieldStrenght = 10
                                hasVelocity = false
                                velocityX = 0
                                velocityY = 0
                            }

                            Button("Bouncy Ball") {
                                fillColor = Color.yellow
                                strokeColor = Color.white
                                lineWidth = 1
                                radius = 10
                                affectedByGravity = true
                                isDynamic = true
                                allowsRotation = true
                                pinned = false
                                density = 1
                                friction = 0
                                linearDamping = 0
                                restitution = 1.0
                                charge = -0.1
                                hasAMagneticField = false
                                hasVelocity = true
                                velocityX = 500
                                velocityY = 500
                            }
                        }

                        Section("Style") {
                            ColorPicker("🎨 Fill Color", selection: $fillColor)
                            ColorPicker("🎨 Stroke Color", selection: $strokeColor)

                            LabeledContent {
                                TextField(value: $lineWidth, format: .number) {
                                    Text("🖊️ Line Width")
                                }
                                .multilineTextAlignment(.trailing)
                            } label: {
                                Text("🖊️ Line Width")
                            }

                            LabeledContent {
                                TextField(value: $radius, format: .number) {
                                    Text("↕️ Radius")
                                }
                                .multilineTextAlignment(.trailing)
                            } label: {
                                Text("↕️ Radius")
                            }

                        }

                        Section("Physics") {
                            Toggle("🍏 Affected by Gravity", isOn: $affectedByGravity)
                            Toggle("🌊 Is Dynamic", isOn: $isDynamic)
                            Toggle("🔄 Allows Rotation", isOn: $allowsRotation)
                            Toggle("📌 Pinned", isOn: $pinned)

                            LabeledContent {
                                TextField(value: $density, format: .number) {
                                    Text("🪨 Density")
                                }
                                .multilineTextAlignment(.trailing)
                            } label: {
                                Text("🪨 Density")
                            }

                            LabeledContent {

                                VStack(alignment: .trailing) {
                                    Slider(value: $friction, in: 0.0...1.0, step: 0.1)
                                    Text(String(format: "%.2f", friction))

                                }


                            } label: {
                                Text("⚙️ Friction")
                            }

                            LabeledContent {
                                VStack(alignment: .trailing) {
                                    Slider(value: $linearDamping, in: 0.0...100.0, step: 0.1)
                                    Text(String(format: "%.2f", linearDamping))
                                }
                            } label: {
                                Text("💨 Linear Damping")
                            }

                            LabeledContent {
                                VStack(alignment: .trailing) {
                                    Slider(value: $restitution, in: 0.0...1.0, step: 0.1)
                                    Text(String(format: "%.2f", restitution))
                                }
                            } label: {
                                Text("🎾 Restitution")
                            }
                        }

                        Section("Magnetism") {

                            Toggle("🧲 Has a Magnetic Field", isOn: $hasAMagneticField)

                            if hasAMagneticField {
                                LabeledContent {
                                    TextField(value: $magneticFieldStrenght, format: .number) {
                                        Text("🧲 Magnetic Field Strength")
                                    }
                                    .multilineTextAlignment(.trailing)
                                } label: {
                                    Text("🧲 Magnetic Field Strength")
                                }
                            } else {
                                LabeledContent {
                                    VStack(alignment: .trailing) {
                                        Slider(value: $charge, in: -1.0...1.0, step: 0.1)
                                        Text(String(format: "%.2f", charge))
                                    }
                                } label: {
                                    Text("🔋 Charge")
                                }
                            }
                        }

                        Section("Velocity") {

                            Toggle("🚀 Has Velocity", isOn: $hasVelocity)

                            if hasVelocity {
                                LabeledContent {
                                    TextField(value: $velocityX, format: .number) {
                                        Text("➡️ Velocity X")
                                    }
                                    .multilineTextAlignment(.trailing)
                                } label: {
                                    Text("➡️ Velocity X")
                                }

                                LabeledContent {
                                    TextField(value: $velocityY, format: .number) {
                                        Text("⬆️ Velocity X")
                                    }
                                    .multilineTextAlignment(.trailing)
                                } label: {
                                    Text("⬆️ Velocity X")
                                }
                            }
                        }
                    }
                }
                .navigationTitle("SpriteKit Physics")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Reset", systemImage: "trash") {
                            resetOnNextUpdate = true
                        }
                    }
                }
            }

            GeometryReader { geometry in
                SpriteView(scene: scene.gameScene)
                    .onAppear {
                        scene.gameScene.size = geometry.size
                        scene.gameScene.customDelegate = self
                    }
                    .onChange(of: geometry.size) {
                        scene.gameScene.size = geometry.size
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            }
        }
    }
}

@Observable
class GameSceneWrapper {
    let gameScene: GameScene

    init() {
        self.gameScene = GameScene()
        self.gameScene.scaleMode = .aspectFit
    }
}

extension ContentView: GameSceneDelegate {
    func getGravity() -> CGVector {
        .init(dx: CGFloat(gravityX), dy: CGFloat(gravityY))
    }

    func getNode() -> SKNode {
        let circle = SKShapeNode(circleOfRadius: CGFloat(radius))
        circle.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(radius) + CGFloat(lineWidth)/2)

        circle.fillColor = UIColor(fillColor)
        circle.strokeColor = UIColor(strokeColor)
        circle.lineWidth = CGFloat(lineWidth)

        circle.physicsBody?.affectedByGravity = affectedByGravity
        circle.physicsBody?.isDynamic = isDynamic
        circle.physicsBody?.allowsRotation = allowsRotation
        circle.physicsBody?.pinned = pinned
        circle.physicsBody?.density = CGFloat(density)
        circle.physicsBody?.friction = friction
        circle.physicsBody?.linearDamping = linearDamping
        circle.physicsBody?.restitution = restitution

        if hasAMagneticField {
            let electricField = SKFieldNode.electricField()
            electricField.strength = Float(magneticFieldStrenght)
            circle.addChild(electricField)
        } else {
            circle.physicsBody?.charge = charge
            circle.physicsBody?.fieldBitMask = 0x1 << 1
        }

        if hasVelocity {
            circle.physicsBody?.velocity = .init(dx: velocityX, dy: velocityY)
        }

        return circle
    }

    var shouldReset: Bool {
        let shouldReset = resetOnNextUpdate
        resetOnNextUpdate = false
        return shouldReset
    }
}
