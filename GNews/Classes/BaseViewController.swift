//
//  BaseViewController.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit
import RxSwift

fileprivate enum Defaults {
    static let panGestureEndEditingName = "pan_gesture_end_editing"
}

class BaseViewController: UIViewController, UISetupable, Reactive {
    
    // MARK: - Proporties
    var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribeRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addLogoToNavigationItem()
        updateNavigationBar()
    }
    
    // MARK: - Funcs
    func onBackAction() {}
    
    func updateNavigationBar() {
        let backButton = GNNavigationController.GNNavigationBackButtonItem()
        backButton.onClick = {
            defer {
                self.onBackAction()
            }
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
//        let buttonItem = UIBarButtonItem(customView: backButton)
//        buttonItem.tintColor = Color._F68F54
        if let index = navigationController?.viewControllers.firstIndex(of: self), index >= 1 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        }
    }
    
    // MARK: - Overrides
    /**
    Subsrcibe rx elements here
     */
    func subscribeRx() {}
    
    /**
     Add UI here
     */
    func setupUI() {
        view.backgroundColor = Color._F8F7F7
    }
    
}

extension BaseViewController {
    
    func addLogoToNavigationItem() {
        let logoView = NavigationItemLogoView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 68,
                height: 36
            )
        )
        navigationItem.titleView = logoView
    }
    
    func addEndEditingPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(endEditing))
        panGesture.cancelsTouchesInView = false
        panGesture.name = Defaults.panGestureEndEditingName
        view.addGestureRecognizer(panGesture)
    }
    
    func removeEndEditingPangesture() {
        guard let gesture = view.gestureRecognizers?
            .filter({ $0.name == Defaults.panGestureEndEditingName })
            .first else { return }
        view.removeGestureRecognizer(gesture)
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
}
