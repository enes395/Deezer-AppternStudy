import Foundation
import UIKit

enum RequestStatus {
    case succeed
    case failed
}

class ViewModel {
    var callbackForNetworkRequest: ((Result<CallbackActivity, Error>) -> ())?
    private var viewModelData = Int()
    
    func makeNetworkRequest(requestStatus: RequestStatus) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let _self = self else { return }
            switch requestStatus {
            case .succeed:
                _self.viewModelData += 1
                _self.networkRequestDone()
            case .failed:
                print("Network request error occured..")
            }
        }
    }
    
    private func networkRequestDone() {
        self.callbackForNetworkRequest?(.success(.updateUI))
    }
    
    func getViewModelData() -> Int {
        return viewModelData
    }
}

extension ViewModel {
    enum CallbackActivity {
        case updateUI
    }
}

class ViewController {
    private var viewModel: ViewModel!
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        observeViewModel()
    }
    
    func getData(requestStatus: RequestStatus) {
        viewModel.makeNetworkRequest(requestStatus: requestStatus)
    }
    
    private func makeUiUpdate() {
        print("Data: \(viewModel.getViewModelData())")
        print("Make UI update..")
    }
}

extension ViewController {
    private func observeViewModel() {
        self.viewModel.callbackForNetworkRequest = { [weak self] result in
            guard let _self = self else { return }
            switch result {
            case .success(let activity):
                _self.handleViewModelResponse(activity: activity)
            case .failure(_):
                break
            }
        }
    }

    private func handleViewModelResponse(activity: ViewModel.CallbackActivity) {
        switch activity {
        case .updateUI:
            makeUiUpdate()
        }
    }
}

let viewModelToInject = ViewModel()
let vc = ViewController(viewModel: viewModelToInject)
vc.getData(requestStatus: .succeed)
vc.getData(requestStatus: .failed)
vc.getData(requestStatus: .failed)
vc.getData(requestStatus: .succeed)
