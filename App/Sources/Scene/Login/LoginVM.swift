import UIKit
import RxSwift
import RxCocoa
import KakaoSDKAuth
import KakaoSDKUser

class LoginVM: BaseVM {
    let disposeBag = DisposeBag()
    let api = Service()
    let result = PublishRelay<Bool>()

    // MARK: - In/Out
    struct Input {
        let loginButtonTapped: Observable<Void>
    }
    struct Output {

    }

    // MARK: - Transform
    func transform(_ input: Input) -> Output {
        let output = Output()

        input.loginButtonTapped
            .subscribe { [weak self] _ in
                self?.requestKakaoLogin()
            }
            .disposed(by: disposeBag)

        return output
    }

    // MARK: - API
    func requestKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithApp()
        } else {
            loginWithWeb()
        }
    }

    func loginWithWeb() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            // Validation
            if let error = error {
                print(error)
                return
            }

            // 유저 정보
            UserApi.shared.me() { [weak self] (user, error) in
                // Validation
                if let error = error {
                    print(error)
                    return
                }

                guard let accessToken = oauthToken?.accessToken,
                      let self = self else { return }

                self.api.login(accessToken)
                    .subscribe { res in
                        switch res {
                        case .success:
                            self.result.accept(true)
                        case .failure:
                            self.result.accept(false)
                        }
                    }.disposed(by: self.disposeBag)
            }
        }
    }

    func loginWithApp() {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            // Validation
            if let error = error {
                print(error)
                return
            }

            // 유저 정보
            UserApi.shared.me() { [weak self] (user, error) in
                if let error = error {
                    print(error)
                    return
                }

                guard let accessToken = oauthToken?.accessToken,
                      let self = self else { return }

                self.api.login(accessToken)
                    .subscribe { res in
                        switch res {
                        case .success:
                            self.result.accept(true)
                        case .failure:
                            self.result.accept(false)
                        }
                    }.disposed(by: self.disposeBag)
            }
        }
    }
}
