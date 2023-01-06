//
//  AnnounceCell.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 04/01/23.
//

import UIKit

class AnnounceCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var imageAnnounce: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var heartViewBtn: UIButton!
    

    var announce: Announce!{didSet{
        setUpPhotoIndicator()
    }}
    private var imageDisplayed: Int = 0
    
    weak var announceListVM: AnnouncesListVM!
    weak var coordinator: GetAnnounceCoordinator!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpSwipeGesture()
    }
    
    //MARK: - Photo indicator image (showing which image is curretnly showing)
       private func setUpPhotoIndicator(){
           let viewTest = viewWithTag(100)
           viewTest?.removeFromSuperview()
           
           let horizontalStackview = UIStackView()
           horizontalStackview.distribution = .fillProportionally
           horizontalStackview.axis = .horizontal
           horizontalStackview.spacing = 5
           horizontalStackview.translatesAutoresizingMaskIntoConstraints = false
           horizontalStackview.alignment = .center
           
           for index in 0..<announce!.imageRefs.count {
               let indicatorImgView = UIImageView(image: UIImage(systemName: "circle.fill"))
               indicatorImgView.tintColor = .white
               
               
               if index == imageDisplayed {
                   indicatorImgView.heightAnchor.constraint(equalToConstant: CGFloat(10)).isActive = true
                   indicatorImgView.widthAnchor.constraint(equalToConstant: CGFloat(10)).isActive = true
               }else{
                   indicatorImgView.heightAnchor.constraint(equalToConstant: CGFloat(5)).isActive = true
                   indicatorImgView.widthAnchor.constraint(equalToConstant: CGFloat(5)).isActive = true
               }
               
               horizontalStackview.addArrangedSubview(indicatorImgView)
           }
           
           horizontalStackview.tag = 100
           imageAnnounce.addSubview(horizontalStackview)
           horizontalStackview.centerXAnchor.constraint(equalTo: imageAnnounce.centerXAnchor).isActive = true
           horizontalStackview.bottomAnchor.constraint(equalTo: imageAnnounce.bottomAnchor, constant: CGFloat(-10)).isActive = true

       }
       
   //MARK: - Swipe gesture for changing picture
       private func setUpSwipeGesture(){
           imageAnnounce.isUserInteractionEnabled = true
           let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(photoRight))
           swipeRight.direction = .right
           imageAnnounce.addGestureRecognizer(swipeRight)
           let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(photoLeft))
           swipeLeft.direction = .left
           imageAnnounce.addGestureRecognizer(swipeLeft)
       }
       
       @objc func photoLeft() {
           if imageDisplayed < announce!.imageRefs.count - 1 {
               imageAnnounce.sd_setImage(with: URL(string: announce?.imageRefs[imageDisplayed + 1] ?? ""),
                                         placeholderImage: UIImage(systemName: "camera"))
               imageDisplayed += 1
               setUpPhotoIndicator()
           }
    
       }
       @objc func photoRight() {
           if imageDisplayed > 0 {
               imageAnnounce.sd_setImage(with: URL(string: announce?.imageRefs[imageDisplayed - 1] ?? ""),
                                         placeholderImage: UIImage(systemName: "camera"))
               imageDisplayed -= 1
               setUpPhotoIndicator()
           }
       }

    @IBAction func heartViewBtnPressed(_ sender: UIButton) {
        if coordinator.isLoggedIn{
            announceListVM.AddOrRemoveFromFavourite(announce: announce)
        } else {
            coordinator.showLoginView()
        }
    }
}
