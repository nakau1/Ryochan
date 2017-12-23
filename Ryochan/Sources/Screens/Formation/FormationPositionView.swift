//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol FormationPositionViewDelegate: class {
    
    func formationPositionView(_ formationPositionView: FormationPositionView, didTapAt index: Int, portrait: Portrait?)
    
    func formationPositionView(_ formationPositionView: FormationPositionView, didMoveTo percentage: CGPoint, at index: Int, portrait: Portrait?)
}

class FormationPositionView: UIButton {
    
    private let nobodyImage = UIImage(named: "nobody")!
    
    private weak var delegate: FormationPositionViewDelegate!
    
    private var portrait: Portrait?
    
    private var origin: CGPoint!
    private var point: CGPoint!
    
    class func create(delegate: FormationPositionViewDelegate) -> FormationPositionView {
        let ret = FormationPositionView(type: .custom)
        ret.delegate = delegate
        ret.prepare()
        return ret
    }
    
    func set(portrait portraitOrNil: Portrait?, uniform uniformOrNil: Uniform? = nil) {
        let buttonImage = image(portrait: portraitOrNil, uniform: uniformOrNil)
        setImage(buttonImage, for: .normal)
        self.portrait = portraitOrNil
    }
    
    var percentage: CGPoint = .zero {
        didSet {
            guard let parentView = superview else { return }
            let parentSize = parentView.frame.size
            let childSize = frame.size
            frame.origin = convertToAbsolute(percentage: percentage, childSize: childSize, parentSize: parentSize)
        }
    }
    
    var index: Int = 0 {
        didSet {
            tag = index + 100
        }
    }
    
    private func image(portrait portraitOrNil: Portrait?, uniform uniformOrNil: Uniform?) -> UIImage {
        guard
            let portrait = portraitOrNil,
            let full = FullImageGenerator().generateImage(of: portrait, uniform: uniformOrNil)
            else {
                return nobodyImage
        }
        return full.scaled(to: .startingsPositionSize)
    }
    
    private func prepare() {
        frame = CGRect(CGSize.startingsPositionSize)
        //backgroundColor = #colorLiteral(red: 0.7779676649, green: 0.6447482639, blue: 1, alpha: 0.2032052654)
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureDidHandle(gesture:))))
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureDidHandle(gesture:))))
    }
    
    @objc func panGestureDidHandle(gesture: UIPanGestureRecognizer) {
        guard let parentView = superview, let childView = gesture.view else { return }
        let parentSize = parentView.frame.size
        let childSize = childView.frame.size
        
        switch gesture.state {
        case .began:
            origin = gesture.view?.frame.origin
            point  = gesture.translation(in: parentView)
        case .changed:
            let newOrigin = fetchOrigin(of: gesture, in: parentView)
            if check(origin: newOrigin, childSize: childSize, parentSize: parentSize) {
                gesture.view?.frame.origin = newOrigin
            }
        case .ended, .cancelled, .failed:
            let newOrigin = fetchOrigin(of: gesture, in: parentView)
            let percentage = convertToPercentage(absolute: newOrigin, childSize: childSize, parentSize: parentSize)
            delegate.formationPositionView(self, didMoveTo: percentage, at: index, portrait: portrait)
        default:break
        }
    }
    
    @objc func tapGestureDidHandle(gesture: UITapGestureRecognizer) {
        delegate.formationPositionView(self, didTapAt: index, portrait: portrait)
    }
    
    private func fetchOrigin(of gesture: UIPanGestureRecognizer, in view: UIView) -> CGPoint {
        return origin + gesture.translation(in: view) - point
    }
    
    private func check(origin: CGPoint, childSize: CGSize, parentSize: CGSize) -> Bool {
        let i = originInterfaces(childSize, parentSize)
        return i.minX <= origin.x && origin.x <= i.maxX && i.minY <= origin.y && origin.y <= i.maxY
    }
    
    private func convertToPercentage(absolute: CGPoint, childSize: CGSize, parentSize: CGSize) -> CGPoint {
        let i = originInterfaces(childSize, parentSize)
        return CGPoint(
            x: (absolute.x / (i.maxX - i.minX)).percentaged,
            y: (absolute.y / (i.maxY - i.minY)).percentaged
        )
    }
    
    private func convertToAbsolute(percentage: CGPoint, childSize: CGSize, parentSize: CGSize) -> CGPoint {
        let i = originInterfaces(childSize, parentSize)
        return CGPoint(
            x: percentage.x * (i.maxX - i.minX),
            y: percentage.y * (i.maxY - i.minY)
        )
    }
    
    private func originInterfaces(_ childSize: CGSize, _ parentSize: CGSize) -> (minX: CGFloat, minY: CGFloat, maxX: CGFloat, maxY: CGFloat) {
        return (
            minX: 0,
            minY: 0,
            maxX: parentSize.width - childSize.width,
            maxY: parentSize.height - childSize.height
        )
    }
}

private extension CGFloat {
    
    var percentaged : CGFloat {
        if self <= 0 {
            return 0
        } else if 1 <= self {
            return 1
        } else {
            return self
            //return floor(self * 1000) / 1000
        }
    }
}
