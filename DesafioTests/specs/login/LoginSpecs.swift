import Quick
import Nimble
import RxCocoa
import RxSwift
import RxTest

@testable import todo

class LoginSpec: QuickSpec {
    
    override func spec() {
        describe("Login ViewModel") {
            var scheduler: TestScheduler!
            var disposeBag: DisposeBag!
            var authCoordinatorSpy: AuthCoordinatorSpy!
            var viewModel: LoginViewModelProtocol!
            
            beforeEach {
                API.calls = MockCalls()
                disposeBag = DisposeBag()
                authCoordinatorSpy = AuthCoordinatorSpy(window: UIWindow())
                viewModel = LoginViewModel(coordinator: authCoordinatorSpy)
            }
            
            context("if received login action") {
                MockURLProtocol.responseWithStatusCode(code: 200)
                var validEmailObserver: TestableObserver<Bool>!
                var validPasswordObserver: TestableObserver<Bool>!
                
                beforeEach {
                    scheduler = TestScheduler(initialClock: 0)
                    validEmailObserver = scheduler.createObserver(Bool.self)
                    validPasswordObserver = scheduler.createObserver(Bool.self)
                    
                    scheduler.createColdObservable([next(30, ())])
                        .bind(to: viewModel.inputs.loginAction)
                        .disposed(by: disposeBag)
                    
                    viewModel.outputs.isValidEmail
                        .drive(validEmailObserver)
                        .disposed(by: disposeBag)
                    
                    viewModel.outputs.isValidPassword
                        .drive(validPasswordObserver)
                        .disposed(by: disposeBag)
                }
                
                context("with valid email and password") {
                    beforeEach {
                        scheduler.createColdObservable([next(10, "john@improving.com")])
                            .bind(to: viewModel.inputs.email)
                            .disposed(by: disposeBag)
                        
                        scheduler.createColdObservable([next(20, "123456")])
                            .bind(to: viewModel.inputs.password)
                            .disposed(by: disposeBag)
                        
                        scheduler.start()
                    }
                    
                    it("should return valid email and password") {
                        expect(validEmailObserver.events).to(equal([Recorded.next(30, true)]))
                        expect(validPasswordObserver.events).to(equal([Recorded.next(30, true)]))
                    }
                    
                    it("should go to home screen") {
                        expect(authCoordinatorSpy.authSceneWasFinished).toEventually(beTrue())
                    }
                }
                
                context("with invalid login/password") {
                    beforeEach {
                        scheduler.createColdObservable([next(10, "invalidEmail")])
                            .bind(to: viewModel.inputs.email).disposed(by: disposeBag)

                        scheduler.createColdObservable([next(20, "123")])
                            .bind(to: viewModel.inputs.password).disposed(by: disposeBag)

                        scheduler.start()
                    }

                    it("should return invalid email and password") {
                        expect(validEmailObserver.events).to(equal([Recorded.next(30, false)]))
                        expect(validPasswordObserver.events).to(equal([Recorded.next(30, false)]))
                    }
                    
                    it("should not go to home screen") {
                        expect(authCoordinatorSpy.authSceneWasFinished).toEventually(beFalse())
                    }
                }
            }
        }
    }
    
}

