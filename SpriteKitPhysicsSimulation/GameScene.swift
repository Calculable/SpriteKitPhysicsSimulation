import SpriteKit

protocol GameSceneDelegate {
    func getNode() -> SKNode
    func getGravity() -> CGVector
    var shouldReset: Bool { get }
    func selectNode(_ node: SKNode?)
}

@objcMembers
class GameScene: SKScene {

    var customDelegate: GameSceneDelegate!

    enum PhysicsCategories {
        static let none: UInt32 = 0
        static let node: UInt32 = 0x1
    }

    override func didMove(to view: SKView) {
        setupScenePhysics()
        physicsWorld.contactDelegate = self
    }

    private func setupScenePhysics() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.contactTestBitMask = PhysicsCategories.node
        physicsBody?.collisionBitMask = PhysicsCategories.none
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
    }

    override func didChangeSize(_ oldSize: CGSize) {
        setupScenePhysics()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {

            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)

            if let firstNode = tappedNodes.first {
                customDelegate.selectNode(firstNode)
            } else {
                // Add a new node
                let node = customDelegate.getNode()
                node.position = CGPoint(x: location.x, y: location.y)
                node.physicsBody?.categoryBitMask = PhysicsCategories.node
                physicsBody?.collisionBitMask = PhysicsCategories.node
                node.physicsBody?.contactTestBitMask = PhysicsCategories.node
                addChild(node)
                customDelegate.selectNode(nil)
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        physicsWorld.gravity = customDelegate.getGravity()

        if customDelegate.shouldReset {
            for child in children {
                if !(child is SKAudioNode) {
                    child.removeFromParent()
                }
            }
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print("collision")
    }
}
