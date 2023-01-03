//
//  FavouriteViewUikitCell.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 27/12/22.
//

import UIKit

class FavouriteViewUikitCell: UITableViewCell {

    
    @IBOutlet weak var ImageAnnounce: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    
    weak var favouriteVM: FavouriteVM!
    var announce: Announce!{didSet{
        setUpPhotoIndicator()
    }}
    
    private var imageDisplayed: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpSwipeGesture()
        setUpHeartView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        ImageAnnounce.addSubview(horizontalStackview)
        horizontalStackview.centerXAnchor.constraint(equalTo: ImageAnnounce.centerXAnchor).isActive = true
        horizontalStackview.bottomAnchor.constraint(equalTo: ImageAnnounce.bottomAnchor, constant: CGFloat(-10)).isActive = true

    }
    
//MARK: - Swipe gesture for changing picture
    private func setUpSwipeGesture(){
        ImageAnnounce.isUserInteractionEnabled = true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(photoRight))
        swipeRight.direction = .right
        ImageAnnounce.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(photoLeft))
        swipeLeft.direction = .left
        ImageAnnounce.addGestureRecognizer(swipeLeft)
    }
    
    @objc func photoLeft() {
        if imageDisplayed < announce!.imageRefs.count - 1 {
            ImageAnnounce.sd_setImage(with: URL(string: announce?.imageRefs[imageDisplayed + 1] ?? ""),
                                      placeholderImage: UIImage(systemName: "camera"))
            imageDisplayed += 1
            setUpPhotoIndicator()
        }
 
    }
    @objc func photoRight() {
        if imageDisplayed > 0 {
            ImageAnnounce.sd_setImage(with: URL(string: announce?.imageRefs[imageDisplayed - 1] ?? ""),
                                      placeholderImage: UIImage(systemName: "camera"))
            imageDisplayed -= 1
            setUpPhotoIndicator()
        }
    }
    
//MARK: - Heart Image set up + gesture
    private func setUpHeartView(){
        let imageHeart = UIImage(systemName: "heart.fill")
        let heartView = UIImageView(image: imageHeart)
        heartView.tintColor = .red
        heartView.translatesAutoresizingMaskIntoConstraints = false
        heartView.isUserInteractionEnabled = true
        heartView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:))))
        ImageAnnounce.addSubview(heartView)
        heartView.rightAnchor.constraint(equalTo: ImageAnnounce.rightAnchor).isActive = true
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        favouriteVM.AddOrRemoveFromFavourite(announce: announce!)
    }
    
}
