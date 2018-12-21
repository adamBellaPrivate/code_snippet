//
//  ProfileViewController.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import UIKit

protocol ProfileDisplayLogic: class {
    func showNotLoggedInView()
    func showLoggedInView()
}

class ProfileViewController: UIViewController, CustomTabBarItemProtocol {
    var customTabBarItem: UITabBarItem {
        let item = UITabBarItem(title: .none, image: #imageLiteral(resourceName: "profileInactive"), selectedImage: #imageLiteral(resourceName: "profileActive"))
        item.tag = 2
        return item
    }

    var shouldUseNavigationController: Bool {
        return true
    }

    private lazy var interactor: ProfileBusinessLogic & ProfileDataStore = ProfileInteractor(self)
    private lazy var router: ProfileRoutingLogic = ProfileRouter(resource: self, dataStore: interactor)

    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet private weak var lblWelcomeMessage: UILabel! {
        didSet {
            lblWelcomeMessage.text = "screen.profile.welcome.message".localized
        }
    }
    @IBOutlet private weak var btnLogIn: ActionButton! {
        didSet {
            btnLogIn.setTitle("screen.profile.button.log_in.title".localized, for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenAppearance()
    }
}

extension ProfileViewController: ProfileDisplayLogic {
    final func showNotLoggedInView() {
         applyViewsVisibility(true)
    }

    final func showLoggedInView() {
        applyViewsVisibility(false)
    }
}

private extension ProfileViewController {
    final func setupScreenAppearance() {
        navigationItem.title = "screen.profile.title".localized
    }

    @IBAction final func actionLogIn(_ sender: Any) {
        interactor.fakeLogIn()
    }

    @IBAction final func actionLogOut(_ sender: Any) {
        interactor.fakeLogOut()
    }

    final func applyViewsVisibility(_ shouldShowLogin: Bool) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let wSelf = self else { return }
            wSelf.btnLogIn.alpha = shouldShowLogin.value
            wSelf.lblWelcomeMessage.alpha = (!shouldShowLogin).value
            wSelf.btnExit.alpha = (!shouldShowLogin).value
        }
    }
}
