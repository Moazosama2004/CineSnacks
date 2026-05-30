//
//  OnboardingCollectionViewCell.swift
//  CineSnacks
//
//  Created by Moaz on 29/05/2026.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet var slideImageView: UIImageView!
    @IBOutlet var slideTitle: UILabel!
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    func setup(slide: OnboardingSlide) {
        slideImageView.image = slide.image
        
        slideTitle.text = slide.tilte
    }
}
