//
//  HomePageUIkit.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 05/01/23.
//
import Combine
import SDWebImage
import UIKit

class HomePageUIkit: UIViewController{


    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var categoriesImgStack: UIStackView!
    
    
    let coordinator: GetAnnounceCoordinator
    let categoriesVM = CategoriesVM()
    var cancellables = Set<AnyCancellable>()
    
    private var searchBar: UISearchController = {
        let sb = UISearchController()
        sb.searchBar.placeholder = "Search"
        sb.searchBar.searchTextField.backgroundColor = .white
        sb.searchBar.searchBarStyle = .minimal
        sb.searchBar.backgroundColor = .systemGray5
        sb.hidesNavigationBarDuringPresentation = false
        return sb
    }()
    
    
    init(coordinator: GetAnnounceCoordinator){
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        suscribeToCategoriesVM()
        setUpMainStackView()
        setUpSearchBar()
    }
  


    func setUpMainStackView(){

        mainStackView.insertArrangedSubview(searchBar.searchBar, at: 0)
        
        let announceViewVC = AnnouncesListViewUikit(coordinator: coordinator, isScrollable: false)
        addChild(announceViewVC)
        mainStackView.addArrangedSubview(announceViewVC.view)
        
        announceViewVC.view.translatesAutoresizingMaskIntoConstraints = false
        announceViewVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        announceViewVC.didMove(toParent: self)
    }
    
//MARK: - Get Categories
    
    func suscribeToCategoriesVM(){
        categoriesVM.getCategories()
        categoriesVM.$categories
            .receive(on: DispatchQueue.main)
            .sink{[weak self] _ in
                self?.setUpCategoriesImgStack()
            }
            .store(in: &cancellables)
    }
    
    func setUpCategoriesImgStack(){
        categoriesImgStack.subviews.forEach{$0.removeFromSuperview()}
        categoriesVM.categories.forEach{cat in
            
            //create Img View
            let imgView = UIImageView()
            imgView.translatesAutoresizingMaskIntoConstraints = false
            imgView.widthAnchor.constraint(equalToConstant: 200).isActive = true
            imgView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            imgView.layer.cornerRadius = 10
            imgView.clipsToBounds = true
            imgView.sd_setImage(with: URL(string: cat.Image), placeholderImage: UIImage(systemName: "camera"))
            
            //Create titleLabel
            let catTitleLabel = UILabel()
            catTitleLabel.text = cat.Name
            catTitleLabel.textColor = .white
            catTitleLabel.font = .systemFont(ofSize: 22, weight: .bold)
            
            catTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            imgView.addSubview(catTitleLabel)
            catTitleLabel.leadingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: 8).isActive = true
            catTitleLabel.bottomAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -8).isActive = true
            
            imgView.isUserInteractionEnabled = true
            imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(catImgTapped(_:))))
            
            categoriesImgStack.addArrangedSubview(imgView)
        }
    }
    
    @objc func catImgTapped(_ sender: UITapGestureRecognizer){
        sender.view?.subviews.forEach{view in
            if let label = view as? UILabel {
                let category = label.text! as String
                coordinator.ShowFilteredAnnounces(searchText: "", category: category, minPrice: 0, maxPrice: 1000, noOlderThanDate: nil)
            }
        }
    }

}

//MARK: - SearchBar setUp
extension HomePageUIkit: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        coordinator.showFilterView()
        return false
    }
    
    func setUpSearchBar(){
        searchBar.searchBar.delegate = self
        navigationItem.searchController = searchBar
    }
}
