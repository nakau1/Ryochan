//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// PortraitPreviewViewのデリゲートプロトコル
protocol PortraitPreviewViewDelegate: class {
    
    func categoryForPortraitPreviewView(_ previewView: PortraitPreviewView) -> Category
}

/// 似顔絵画像の設定プレビュー用イメージビュー
class PortraitPreviewView: UIImageView {
    
    weak var delegate: PortraitPreviewViewDelegate?
    
    var portrait: Portrait!
    
    private var panGestureFirstPoint: CGPoint = .zero
    private var panGestureFirstOrigin: CGPoint = .zero
    private var panGestureFirstSeparate: CGFloat = 0
    
    /// 画像を更新する
    func reloadData() {
        image = PortraitImageGenerator().generateImage(of: portrait)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(didRecognizePanGesture(_:)))
        addGestureRecognizer(gesture)
    }
    
    @objc private func didRecognizePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let category = delegate?.categoryForPortraitPreviewView(self), !category.movableType.isNotMovable else {
            return
        }
        
        switch gesture.state {
        case .began:
            setPanGestureFirstValues(category: category, gesture: gesture)
        case .changed:
            updatePortraitImage(category: category, gesture: gesture)
        default: break
        }
    }
    
    private func setPanGestureFirstValues(category: Category, gesture: UIPanGestureRecognizer) {
        panGestureFirstOrigin = category.parts(of: portrait).position
        panGestureFirstPoint  = gesture.translation(in: self)
        panGestureFirstSeparate = category.parts(of: portrait).separate
    }
    
    private func updatePortraitImage(category: Category, gesture: UIPanGestureRecognizer) {
        switch category.movableType {
        case .freely:
            updatePosition(
                to: calculatedPosition(gesture: gesture),
                category: category
            )
        case let .vertically(area):
            updateVerticalPosition(
                to: calculatedPosition(gesture: gesture).y,
                category: category,
                movableArea: area
            )
        case let .both(area):
            updateVerticalPosition(
                to: calculatedPosition(gesture: gesture).y,
                category: category,
                movableArea: area
            )
            category.parts(of: portrait).separate = calculatedSeparate(gesture: gesture)
        default:break
        }
        reloadData()
    }
    
    private func calculatedPosition(gesture: UIPanGestureRecognizer) -> CGPoint {
        let newPoint = gesture.translation(in: self)
        return panGestureFirstOrigin + newPoint - panGestureFirstPoint
    }
    
    private func calculatedSeparate(gesture: UIPanGestureRecognizer) -> CGFloat {
        let newPoint = gesture.translation(in: self)
        return panGestureFirstSeparate + newPoint.x - panGestureFirstPoint.x
    }
    
    private func updatePosition(to position: CGPoint, category: Category) {
        category.parts(of: portrait).position = position
    }
    
    private func updateVerticalPosition(to ypos: CGFloat, category: Category, movableArea: CGFloat) {
        if !checkMovableArea(movableArea, ypos: ypos) {
            return
        }
        updatePosition(
            to: CGPoint(panGestureFirstOrigin.x, ypos),
            category: category
        )
    }
    
    private func checkMovableArea(_ movableArea: CGFloat, ypos: CGFloat) -> Bool {
        let min = panGestureFirstOrigin.y - (movableArea / 2)
        let max = panGestureFirstOrigin.y + (movableArea / 2)
        return min <= ypos && ypos <= max
    }
}
