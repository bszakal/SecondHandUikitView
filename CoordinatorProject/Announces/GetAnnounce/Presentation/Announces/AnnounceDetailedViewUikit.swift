//
//  AnnounceDetailedViewUikit.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 03/01/23.
//
import SDWebImage
import UIKit

class AnnounceDetailedViewUikit: UIViewController {

    
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    
    
    let announce: Announce
    
    init(announce: Announce){
        self.announce = announce
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topImage.sd_setImage(with: URL(string: announce.imageRefs[0]), placeholderImage: UIImage(systemName: "camera"))
        bottomImage.sd_setImage(with: URL(string: announce.imageRefs[1]), placeholderImage: UIImage(systemName: "camera"))
    }

}
