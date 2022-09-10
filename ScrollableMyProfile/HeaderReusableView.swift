//
//  HeaderReusableView.swift
//  ScrollableMyProfile
//
//  Created by Saleh Masum on 9/9/2022.
//

import UIKit

struct Track {
    let imageName: String
}

class HeaderReusableView: UICollectionReusableView {
    
    static let reuseIdentifier = "HeaderReusableView"
    
    let imageView = UIImageView()
    var heightConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var isFloating = false 
    
    var track: Track? {
        didSet {
            guard let track = track else { return }
            let image = UIImage(named: track.imageName) ?? UIImage(named: "placeholder")
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HeaderReusableView {
 
    func layout() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        widthConstraint = imageView.widthAnchor.constraint(equalToConstant: 300)
        heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 300)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightConstraint!,
            widthConstraint!
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 300)
    }
    
}

extension HeaderReusableView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        guard let widthConstraint = widthConstraint, let heightCosntraint = heightConstraint else {
            return
        }
        //Scroll
        let normalizedScroll = y / 2
        widthConstraint.constant = 300 - normalizedScroll
        heightCosntraint.constant = 300 - normalizedScroll
        
        if isFloating {
            isHidden = y > 180
        }
        
        //Alpha
        let normalizedAlpha = y / 200
        alpha = 1.0 - normalizedAlpha
    }
}

