//
//  NibView.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit
open class NibView: UIView, NibRepresentable, NibLoadable {
    // MARK: - Properties
    
    public private(set) var contentView: UIView!
    
    open class var bundle: Bundle { Bundle(for: self) }
    open class var nibName: String {
        try! String(describing: self).substringMatches(regex: "[[:word:]]+").first!
    }
    
    // MARK: - Inits
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadNib(Self.nib)
        contentViewDidLoad()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView = loadNib(Self.nib)
        contentViewDidLoad()
    }
    
    // MARK: - Lifecycle
    
    @objc open func contentViewDidLoad() {
        backgroundColor = .clear
    }
}

public protocol NibRepresentable {
    static var bundle: Bundle { get }
    static var nibName: String { get }
}

public extension NibRepresentable where Self: AnyObject {
    
    static var bundle: Bundle {
        Bundle(for: self)
    }
    
    static var nibName: String {
        try! String(describing: self).substringMatches(regex: "[[:word:]]+").first!
    }
    
}

public protocol NibLoadable where Self: NibRepresentable {
    func loadNib(_ nib: UINib) -> UIView?
}

public extension NibLoadable where Self: UIView {
//    @discardableResult
    func loadNib(_ nib: UINib) -> UIView? {
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return nil
        }
        
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.frame = bounds
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            view.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        return view
    }
}


public extension NibRepresentable {
    
    static var nib: UINib {
        UINib(nibName: nibName, bundle: bundle)
    }
    
    static var canLoadNib: Bool {
        bundle.url(forResource: nibName, withExtension: "nib") != nil
    }
    
}

extension String {
    func substringMatches(regex: String) throws -> [String] {
        let regex = try NSRegularExpression(pattern: regex, options: [])
        let range = NSMakeRange(0, (self as NSString).length)
        let matches = regex.matches(in: self, options: [], range: range)
        
        let string = self as NSString
        var substrings = [String]()
        for match in matches {
            substrings.append(string.substring(with: match.range) as String)
        }
        
        return substrings
    }
}
