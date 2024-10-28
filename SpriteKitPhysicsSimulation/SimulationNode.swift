import SpriteKit

class SimulationNode: SKShapeNode {

    var isSelected: Bool = false {
        didSet {
            if isSelected {
                if selectionBox == nil {
                    // Add the box as a child node
                    let boxSize = radius * 2 + 5
                    let boxNode = SKShapeNode(rectOf: CGSize(width: boxSize, height: boxSize))

                    boxNode.position = CGPoint(x: 0, y: 0)
                    boxNode.strokeColor = .red
                    boxNode.lineWidth = 2.0
                    boxNode.zPosition = 10
                    selectionBox = boxNode
                    self.addChild(boxNode)
                }
            } else {
                if let selectionBox {
                    self.removeChildren(in: [selectionBox])
                }
                selectionBox = nil
            }
        }
    }

    let radius: CGFloat
    var selectionBox: SKNode? = nil

    init(radius: CGFloat) {
        self.radius = radius
        super.init()
        let path = CGPath(ellipseIn: CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2), transform: nil)
        self.path = path
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
