//
//  OnboardingViewController.swift
//  CineSnacks
//
//  Created by Moaz on 29/05/2026.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageController: UIPageControl!
    @IBOutlet var nextbtn: UIButton!
    
    @IBOutlet var nextBtnWidth: NSLayoutConstraint!

    @IBOutlet var nextBtnHeight: NSLayoutConstraint!
    
    var slides : [OnboardingSlide] = [
        OnboardingSlide(image: #imageLiteral(resourceName: "onboarding-one"), tilte: "Skip those lengthy lines and order your favorite movie snacks."),
        OnboardingSlide(image: #imageLiteral(resourceName: "onboarding-two"), tilte: "Upgrade your movie experience with snacks delivered to your seat."),
        OnboardingSlide(image: #imageLiteral(resourceName: "onboarding-three"), tilte: "Wide selection of movie snacks, from popcorns and nachos to candies and soft drinks"),
        OnboardingSlide(image: #imageLiteral(resourceName: "onboarding-four"), tilte: "Enjoy hassle-free payment experiencewith secure in-app payment options")
    ]
    
    var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
            updateNextButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "homeNC") as! UINavigationController
            
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    

    func updateNextButton() {
          let isLastSlide = currentPage == slides.count - 1
          
          // Update IBOutlet constraints directly
          nextBtnWidth.constant = isLastSlide ? view.frame.width - 40 : 72
          nextBtnHeight.constant = isLastSlide ? 48 : 72
          
          UIView.animate(withDuration: 0.3) {
              if isLastSlide {
                  self.nextbtn.setImage(nil, for: .normal)
                  self.nextbtn.layer.cornerRadius = 12.0
                  self.nextbtn.setTitle("Get Started", for: .normal)
                  self.nextbtn.setImage(nil, for: .highlighted)
                  self.nextbtn.setImage(nil, for: .selected)
                  self.nextbtn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 30, bottom: 12, right: 30)
                  self.nextbtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
                  self.nextbtn.setTitleColor(.white, for: .normal)
              } else {
                  self.nextbtn.layer.cornerRadius = 36.0
                  self.nextbtn.setTitle("", for: .normal)
                  self.nextbtn.setImage(UIImage(systemName: "arrow.right"), for: .normal)
                  self.nextbtn.contentEdgeInsets = .zero
                  self.nextbtn.tintColor = .white
              }
              self.nextbtn.backgroundColor = UIColor.primaryColor
              self.nextbtn.clipsToBounds = true
              self.view.layoutIfNeeded()
          }
      }
    
}

extension OnboardingViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slide: slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
