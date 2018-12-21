//
//  ProfileInteractor.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProfileBusinessLogic {
    func fakeLogIn()
    func fakeLogOut()
}

protocol ProfileDataStore: class {

}

class ProfileInteractor: ProfileDataStore {
    private var presenter: ProfilePresentationLogic?
    private let defaultsWorker = UserDefaultsWorker()
    private var disposeBag = DisposeBag()

    init(_ resourceView: ProfileDisplayLogic) {
        presenter = ProfilePresenter(resourceView)
        defaultsWorker.userDefaults.rx.observe(Bool.self, Constant.UserDefaultsKey.userLoggedStateKey.rawValue).asDriver(onErrorJustReturn: false).drive(onNext: { [weak self]( _ ) in
            guard let wSelf = self else { return }
            wSelf.fetchUserData()
        }).disposed(by: disposeBag)
    }

    deinit {
        disposeBag = DisposeBag()
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ProfileInteractor: ProfileBusinessLogic {
    final func fetchUserData() {
        guard defaultsWorker.isUserLoggedIn() else {
            presenter?.manageNotLoggedInUser()
            return
        }
        presenter?.manageLoggedInUser()
    }

    final func fakeLogIn() {
        defaultsWorker.changeUserLoggedState(true)
    }

    final func fakeLogOut() {
        defaultsWorker.changeUserLoggedState(false)
    }
}
