//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

enum LayoutConstraintOperator {
    case equal
    case greater
    case less
}

extension UIView {
    
    func addConstraint(topSpaceTo target: Anchorable?, constant: CGFloat = 0, operator ope: LayoutConstraintOperator = .equal, priority: UILayoutPriority = .required) {
        addConstraint(constant: constant, from: topAnchor, to: targetOrSuperview(target).topAnchor, operator: ope, priority: priority)
    }
    
    func addConstraint(bottomSpaceTo target: Anchorable?, constant: CGFloat = 0, operator ope: LayoutConstraintOperator = .equal, priority: UILayoutPriority = .required) {
        addConstraint(constant: constant, from: bottomAnchor, to: targetOrSuperview(target).bottomAnchor, operator: ope, priority: priority)
    }
    
    func addConstraint(leadingSpaceTo target: Anchorable?, constant: CGFloat = 0, operator ope: LayoutConstraintOperator = .equal, priority: UILayoutPriority = .required) {
        addConstraint(constant: constant, from: leadingAnchor, to: targetOrSuperview(target).leadingAnchor, operator: ope, priority: priority)
    }
    
    func addConstraint(trailingSpaceTo target: Anchorable?, constant: CGFloat = 0, operator ope: LayoutConstraintOperator = .equal, priority: UILayoutPriority = .required) {
        addConstraint(constant: constant, from: trailingAnchor, to: targetOrSuperview(target).trailingAnchor, operator: ope, priority: priority)
    }
}

extension UIView {
    
    func addConstraint(centerXOf target: Anchorable?, constant: CGFloat = 0, operator ope: LayoutConstraintOperator = .equal, priority: UILayoutPriority = .required) {
        addConstraint(constant: constant, from: centerXAnchor, to: targetOrSuperview(target).centerXAnchor, operator: ope, priority: priority)
    }
    
    func addConstraint(centerYOf target: Anchorable?, constant: CGFloat = 0, operator ope: LayoutConstraintOperator = .equal, priority: UILayoutPriority = .required) {
        addConstraint(constant: constant, from: centerYAnchor, to: targetOrSuperview(target).centerYAnchor, operator: ope, priority: priority)
    }
    
    func addConstraint(centerOf target: Anchorable?, constant: CGFloat = 0, operator ope: LayoutConstraintOperator = .equal, priority: UILayoutPriority = .required) {
        addConstraint(centerXOf: target, constant: constant, operator: ope, priority: priority)
        addConstraint(centerYOf: target, constant: constant, operator: ope, priority: priority)
    }
}

extension UIView {
    
    func addConstraint(height target: Anchorable?, constant: CGFloat, operator ope: LayoutConstraintOperator = .equal, multiplier: CGFloat = 0, priority: UILayoutPriority = .required) {
        addConstraint(constant: constant, dimension: heightAnchor, operator: ope, multiplier: multiplier, priority: priority)
    }
    
    func addConstraint(width target: Anchorable?, constant: CGFloat, operator ope: LayoutConstraintOperator = .equal, multiplier: CGFloat = 0, priority: UILayoutPriority = .required) {
        addConstraint(constant: constant, dimension: widthAnchor, operator: ope, multiplier: multiplier, priority: priority)
    }
}

extension UIView {
    
    func addConstraint(top: CGFloat?, trailing: CGFloat?, bottom: CGFloat?, leading: CGFloat?, to target: Anchorable?, operator ope: LayoutConstraintOperator = .equal, priority: UILayoutPriority = .required) {
        if top != nil {
            addConstraint(topSpaceTo: target, constant: top!, operator: ope, priority: priority)
        }
        if trailing != nil {
            addConstraint(trailingSpaceTo: target, constant: trailing!, operator: ope, priority: priority)
        }
        if bottom != nil {
            addConstraint(bottomSpaceTo: target, constant: bottom!, operator: ope, priority: priority)
        }
        if leading != nil {
            addConstraint(leadingSpaceTo: target, constant: leading!, operator: ope, priority: priority)
        }
    }
    
    func addConstraint(allSideSpaceTo target: Anchorable?, constant: CGFloat = 0, operator ope: LayoutConstraintOperator = .equal, priority: UILayoutPriority = .required) {
        addConstraint(
            top:      constant,
            trailing: constant,
            bottom:   constant,
            leading:  constant,
            to:       target,
            operator: ope,
            priority: priority
        )
    }
}

private extension UIView {
    
    func addConstraint<T>(constant: CGFloat, from source: NSLayoutAnchor<T>, to target: NSLayoutAnchor<T>, operator ope: LayoutConstraintOperator, priority: UILayoutPriority) {
        prepareConstraint()
        let constraint: NSLayoutConstraint
        switch ope {
        case .equal:
            constraint = source.constraint(equalTo: target, constant: constant)
        case .greater:
            constraint = source.constraint(greaterThanOrEqualTo: target, constant: constant)
        case .less:
            constraint = source.constraint(lessThanOrEqualTo: target, constant: constant)
        }
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func addConstraint(constant: CGFloat, dimension: NSLayoutDimension, operator ope: LayoutConstraintOperator, multiplier: CGFloat = 0, priority: UILayoutPriority) {
        prepareConstraint()
        let constraint: NSLayoutConstraint
        switch ope {
        case .equal:
            constraint = dimension.constraint(equalTo: dimension, multiplier: multiplier, constant: constant)
        case .greater:
            constraint = dimension.constraint(greaterThanOrEqualTo: dimension, multiplier: multiplier, constant: constant)
        case .less:
            constraint = dimension.constraint(lessThanOrEqualTo: dimension, multiplier: multiplier, constant: constant)
        }
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func prepareConstraint() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func targetOrSuperview(_ target: Anchorable?) -> Anchorable {
        guard let ret = (target ?? superview) else {
            fatalError("not exists target or superview.")
        }
        return ret
    }
}

extension UIView: Anchorable {}
extension UILayoutGuide: Anchorable {}

protocol Anchorable {
    
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    
    var leftAnchor: NSLayoutXAxisAnchor { get }
    
    var rightAnchor: NSLayoutXAxisAnchor { get }
    
    var topAnchor: NSLayoutYAxisAnchor { get }
    
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    
    var widthAnchor: NSLayoutDimension { get }
    
    var heightAnchor: NSLayoutDimension { get }
    
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}
