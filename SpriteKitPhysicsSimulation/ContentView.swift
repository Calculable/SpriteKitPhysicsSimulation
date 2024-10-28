import SwiftUI
import SpriteKit
import UIKit

struct ContentView: View {

    let musicNode = SKAudioNode(fileNamed: "TheEntertainer.mp3")

    private let scene: GameScene = {
        let gameScene = GameScene()
        gameScene.scaleMode = .aspectFit
        return gameScene
    }()

    @State private var selectedNode: SimulationNode? = nil
    @State private var resetOnNextUpdate: Bool = false

    //Segmented Control Properties
    enum ViewOption: String, CaseIterable, Identifiable {
        case scene, nodes, actions, audio
        var id: String { self.rawValue }
    }

    @State private var selectedViewOption: ViewOption = .scene

    //Scene Properties
    @State private var gravityX: Float = 0.0
    @State private var gravityY: Float = 0.0

    //Node Properties
    @State private var fillColor: Color = Color.blue
    @State private var strokeColor: Color = Color.white
    @State private var lineWidth: Float = 1.0
    @State private var radius: Float = 10.0

    @State private var affectedByGravity: Bool = true
    @State private var isDynamic = true
    @State private var allowsRotation = true
    @State private var pinned = false
    @State private var density: Float = 1.0
    @State private var friction: CGFloat = 0.2
    @State private var linearDamping: CGFloat = 0.1
    @State private var restitution: CGFloat = 0.2

    @State private var charge: CGFloat = -0.1
    @State private var hasAMagneticField: Bool = false
    @State private var magneticFieldStrenght: Int = 100

    @State private var hasVelocity: Bool = false
    @State private var velocityX: Int = 0
    @State private var velocityY: Int = 0

    //SKAction Properties
    @State private var scaleFactor: Float = 2
    @State private var scaleDuration: Float = 1

    @State private var fadeAlphaValue: Float = 0.5
    @State private var fadeAlphaDuration: Float = 1

    @State private var angularImpulse: Float = 1
    @State private var angularImpulseDuration: Float = 1

    @State private var forceX: Float = 1
    @State private var forceY: Float = 1
    @State private var forceDuration: Float = 1

    @State private var impulseX: Float = 1
    @State private var impulseY: Float = 1
    @State private var impulseDuration: Float = 1

    @State private var torque: Float = 1
    @State private var torqueDuration: Float = 1

    @State private var colorizeColor: Color = .green
    @State private var colorBlendFactor: Float = 1
    @State private var colorBlendDuration: Float = 1

    @State private var falloff: Float = 1
    @State private var falloffDuration: Float = 1

    @State private var moveX: Float = 1
    @State private var moveY: Float = 1
    @State private var moveDuration: Float = 1

    @State private var reachX: Float = 1
    @State private var reachY: Float = 1
    @State private var reachDuration: Float = 1

    @State private var resizeWidth: Float = 1
    @State private var resizeHeight: Float = 1
    @State private var resizeDuration: Float = 1

    @State private var rotationAngle: Float = 1
    @State private var rotationDuration: Float = 1

    @State private var speed: Float = 1
    @State private var speedDuration: Float = 1

    var body: some View {
        HStack(spacing: 0) {
            NavigationStack {
                VStack(spacing: 0) {
                    Form {
                        Picker("Select an Option", selection: $selectedViewOption) {
                            Text("Scene").tag(ViewOption.scene)
                            Text("Nodes").tag(ViewOption.nodes)
                            Text("Actions").tag(ViewOption.actions)
                            Text("Audio").tag(ViewOption.audio)
                        }
                        .pickerStyle(SegmentedPickerStyle())

                        switch selectedViewOption {
                            case .scene:
                                sceneView
                            case .nodes:
                                nodesView
                            case .actions:
                                actionsView
                            case .audio:
                                audioView
                        }

                        Section("Copyright Info") {
                            Link("App Icon by SAM Designs from Noun Project (CC BY 3.0)", destination: URL(string: "https://thenounproject.com/browse/icons/term/physics/")!)
                            Link("\"The Entertainer\" Kevin MacLeod (incompetech.com) Licensed under Creative Commons: By Attribution 4.0 License", destination: URL(string: "https://incompetech.com/music/royalty-free/music.html")!)

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
                SpriteView(scene: scene)
                    .onAppear {
                        scene.size = geometry.size
                        scene.customDelegate = self
                        scene.addChild(musicNode)

                        musicNode.run(SKAction.pause())
                    }
                    .onChange(of: geometry.size) {
                        scene.size = geometry.size
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            }
        }
    }

    var sceneView: some View {
        Group {
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
        }
    }

    var nodesView: some View {
        Group {
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

    var actionsView: some View {
        Group {
            Section("Scale") {
                LabeledFloatInput(value: $scaleFactor, text: "❎ Factor")
                LabeledFloatInput(value: $scaleDuration, text: "⏱️ Duration")
                Button("Run!") {
                    let action = SKAction.scale(by: CGFloat(scaleFactor), duration: TimeInterval(scaleDuration))
                    selectedNode?.run(action)
                }
            }

            //Not supported on SKShapeNode
            /*Section("Resize") {
             LabeledFloatInput(value: $resizeWidth, text: "↔️ Width")
             LabeledFloatInput(value: $resizeHeight, text: "↕️ Height")
             LabeledFloatInput(value: $resizeDuration, text: "⏱️ Duration")

             Button("Run!") {
             let action = SKAction.resize(toWidth: CGFloat(resizeWidth), height: CGFloat(resizeHeight), duration: TimeInterval(resizeDuration))
             selectedNode?.run(action)
             }
             }*/

            //Not supported on SKShapeNode
            /*Section("Reach") {
             LabeledFloatInput(value: $reachX, text: "↔️ X")
             LabeledFloatInput(value: $reachY, text: "↕️ Y")
             LabeledFloatInput(value: $reachDuration, text: "⏱️ Duration")

             Button("Run!") {
             let action = SKAction.reach(to: .init(x: CGFloat(reachX), y: CGFloat(reachY)), rootNode: scene, duration: TimeInterval(reachDuration))
             selectedNode?.run(action)
             }
             }*/

            Section("Move") {
                LabeledFloatInput(value: $moveX, text: "↔️ X")
                LabeledFloatInput(value: $moveY, text: "↕️ Y")
                LabeledFloatInput(value: $moveDuration, text: "⏱️ Duration")

                Button("Run!") {
                    let action = SKAction.move(to: .init(x: CGFloat(moveX), y: CGFloat(moveY)), duration: TimeInterval(moveDuration))
                    selectedNode?.run(action)
                }
            }

            Section("Force") {
                LabeledFloatInput(value: $forceX, text: "↔️ X")
                LabeledFloatInput(value: $forceY, text: "↕️ Y")
                LabeledFloatInput(value: $forceDuration, text: "⏱️ Duration")

                Button("Run!") {
                    let action = SKAction.applyForce(.init(dx: CGFloat(forceX), dy: CGFloat(forceY)), duration: TimeInterval(forceDuration))
                    selectedNode?.run(action)
                }
            }

            Section("Impulse") {
                LabeledFloatInput(value: $impulseX, text: "↔️ X")
                LabeledFloatInput(value: $impulseY, text: "↕️ Y")
                LabeledFloatInput(value: $impulseDuration, text: "⏱️ Duration")

                Button("Run!") {
                    let action = SKAction.applyImpulse(.init(dx: CGFloat(forceX), dy: CGFloat(forceY)), duration: TimeInterval(forceDuration))
                    selectedNode?.run(action)
                }
            }

            Section("Torque") {
                LabeledFloatInput(value: $torque, text: "🔄 Torque")
                LabeledFloatInput(value: $torqueDuration, text: "⏱️ Duration")

                Button("Run!") {
                    let action = SKAction.applyTorque(CGFloat(torque), duration: TimeInterval(torqueDuration))
                    selectedNode?.run(action)
                }
            }

            Section("Rotation") {
                LabeledFloatInput(value: $rotationAngle, text: "📐 Angle")
                LabeledFloatInput(value: $rotationDuration, text: "⏱️ Duration")

                Button("Run!") {
                    let action = SKAction.rotate(byAngle: CGFloat(rotationAngle), duration: TimeInterval(rotationDuration))
                    selectedNode?.run(action)
                }
            }

            Section("Angular Impulse") {
                LabeledFloatInput(value: $angularImpulse, text: "🔄 Angular Impulse")
                LabeledFloatInput(value: $angularImpulseDuration, text: "⏱️ Duration")
                Button("Run!") {
                    let action = SKAction.applyAngularImpulse(CGFloat(angularImpulse), duration: TimeInterval(angularImpulseDuration))
                    selectedNode?.run(action)
                }
            }

            Section("Fade") {
                LabeledFloatInput(value: $fadeAlphaValue, text: "🫥 Alpha")
                LabeledFloatInput(value: $fadeAlphaDuration, text: "⏱️ Duration")
                Button("Run!") {
                    let action = SKAction.fadeAlpha(to: CGFloat(fadeAlphaValue), duration: TimeInterval(fadeAlphaDuration))
                    selectedNode?.run(action)
                }
            }

            Section("Speed") {
                LabeledFloatInput(value: $speed, text: "🚀 Speed")
                LabeledFloatInput(value: $speedDuration, text: "⏱️ Duration")

                Button("Run!") {
                    let action = SKAction.speed(to: CGFloat(speed), duration: TimeInterval(speedDuration))
                    selectedNode?.run(action)
                }
            }

            Section("Custom Action") {
                Button("Run!") {
                    let action = SKAction.customAction(withDuration: 1, actionBlock: { _, _ in
                        print("custom action")
                    })
                    selectedNode?.run(action)
                }
            }
        }.disabled(selectedNode == nil)
    }

    var audioView: some View {
        Group {

            Section("Controls") {
                Button("Play") {
                    musicNode.run(SKAction.play())
                }

                Button("Pause") {
                    musicNode.run(SKAction.pause())
                }

                Button("Playbackrate +") {
                    musicNode.run(SKAction.changePlaybackRate(by: 0.1, duration: TimeInterval(0.2)))
                }

                Button("Playbackrate -") {
                    musicNode.run(SKAction.changePlaybackRate(by: -0.1, duration: TimeInterval(0.2)))
                }

                //Only for 3d
                /*Button("Reverb +") {
                 musicNode.run(SKAction.changeReverb(by: 0.1, duration: TimeInterval(0.2)))
                 }

                 Button("Reverb -") {
                 musicNode.run(SKAction.changeReverb(by: -0.1, duration: TimeInterval(0.2)))
                 }*/

                Button("Volume +") {
                    musicNode.run(SKAction.changeVolume(by: 0.1, duration: TimeInterval(0.2)))
                }

                Button("Volume -") {
                    musicNode.run(SKAction.changeVolume(by: -0.1, duration: TimeInterval(0.2)))
                }

                //Only works with stereo files
                /*Button("Stereo move right") {
                 musicNode.run(SKAction.stereoPan(to: 1, duration: TimeInterval(0.2)))
                 }

                 Button("Stereo move left") {
                 musicNode.run(SKAction.stereoPan(to: -1, duration: TimeInterval(0.2)))
                 }*/
            }
        }
    }
}

extension ContentView: GameSceneDelegate {
    func getGravity() -> CGVector {
        .init(dx: CGFloat(gravityX), dy: CGFloat(gravityY))
    }

    func getNode() -> SKNode {

        let circle = SimulationNode(radius: CGFloat(radius))
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

    func selectNode(_ node: SKNode?) {
        if node == nil {
            selectedNode = nil
        }

        //Deselect all other nodes, and mark the selected node
        for simulationNode in scene.children.compactMap({ $0 as? SimulationNode }) {
            if node == simulationNode {
                simulationNode.isSelected = true
                selectedNode = simulationNode
            } else {
                simulationNode.isSelected = false
            }
        }

    }
}
