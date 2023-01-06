//
//  HomePageUikitTest.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 05/01/23.
//

import UIKit

class HomePageUikitTest: UIViewController {
    
    let coordinator: GetAnnounceCoordinator

    
    init(coordinator: GetAnnounceCoordinator){
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let testScrollView = UIScrollView()
        view.addSubview(testScrollView)
        testScrollView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        testScrollView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        testScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        testScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        testScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //testScrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: testScrollView.fram).isActive = true
        
        
        let testStack = UIStackView()
        testStack.axis = .vertical
        testStack.distribution = .fill
//
//

        testStack.translatesAutoresizingMaskIntoConstraints = false
////        let margins = view.layoutMarginsGuide
//        testStack.topAnchor.constraint(equalTo: testScrollView.topAnchor).isActive = true
//        testStack.bottomAnchor.constraint(equalTo: testScrollView.bottomAnchor).isActive = true
//        testStack.leadingAnchor.constraint(equalTo: testScrollView.leadingAnchor).isActive = true
//        testStack.trailingAnchor.constraint(equalTo: testScrollView.trailingAnchor).isActive = true
//        testStack.widthAnchor.constraint(equalTo: testScrollView.widthAnchor).isActive = true
//
//        let testLabel = UILabel()
//        testLabel.text = "TEST"
//        testStack.addArrangedSubview(testLabel)
//
        let testLabel2 = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        testLabel2.text = "TEST"
//        testScrollView.addSubview(testLabel2)
        
        let testViewContainer = UIView()
        testViewContainer.addSubview(testStack)
//        testViewContainer.addSubview(testLabel2)

//
//        testStack.addArrangedSubview(testLabel)
        
       
        //view.addSubview(announceViewVC.view)
//        let uiviewTest = UIView(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 700))
//        uiviewTest.addSubview(announceViewVC.view)
   
        //testStack.insertArrangedSubview(testLabel2, at:0)
        //testScrollView.addSubview(testStack)
        //testViewContainer.addSubview(announceViewVC.view)
        testScrollView.addSubview(testViewContainer)
        testViewContainer.translatesAutoresizingMaskIntoConstraints = false
        testViewContainer.topAnchor.constraint(equalTo: testScrollView.topAnchor).isActive = true
        testViewContainer.bottomAnchor.constraint(equalTo: testScrollView.bottomAnchor).isActive = true
        testViewContainer.leadingAnchor.constraint(equalTo: testScrollView.leadingAnchor).isActive = true
        testViewContainer.trailingAnchor.constraint(equalTo: testScrollView.trailingAnchor).isActive = true
        testViewContainer.widthAnchor.constraint(equalTo: testScrollView.widthAnchor).isActive = true
        
                testStack.topAnchor.constraint(equalTo: testViewContainer.topAnchor).isActive = true
                testStack.bottomAnchor.constraint(equalTo: testViewContainer.bottomAnchor).isActive = true
                testStack.leadingAnchor.constraint(equalTo: testViewContainer.leadingAnchor).isActive = true
                testStack.trailingAnchor.constraint(equalTo: testViewContainer.trailingAnchor).isActive = true
        testStack.heightAnchor.constraint(equalTo: testViewContainer.heightAnchor).isActive = true
        
        let announceViewVC = AnnouncesListViewUikit(coordinator: coordinator)
        addChild(announceViewVC)
        testStack.addArrangedSubview(announceViewVC.view)
        
        //testViewContainer.addSubview(testStack)
        
        testScrollView.addSubview(testViewContainer)
        announceViewVC.didMove(toParent: self)
        
   
//
//        announceViewVC.view.translatesAutoresizingMaskIntoConstraints = false
//        announceViewVC.view.topAnchor.constraint(equalTo: testLabel2.bottomAnchor).isActive = true
//        announceViewVC.view.bottomAnchor.constraint(equalTo: testViewContainer.bottomAnchor).isActive = true
//        announceViewVC.view.leadingAnchor.constraint(equalTo: testLabel2.leadingAnchor).isActive = true
//        announceViewVC.view.trailingAnchor.constraint(equalTo: testLabel2.trailingAnchor).isActive = true
        //announceViewVC.view.topAnchor.constraint(equalTo: testLabel2.bottomAnchor).isActive = true
        //announceViewVC.view.widthAnchor.constraint(equalTo: testViewContainer.widthAnchor).isActive = true
 
        
        
        
    }


}
