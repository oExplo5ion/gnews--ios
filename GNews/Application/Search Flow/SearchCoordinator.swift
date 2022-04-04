//
//  SearchCoordinator.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation

class SearchCoordinator: BaseCoordinator {
    
    // MARK: - Closures
    var onRequestShow: ((Article) -> Void)?
    
    // MARK: - Proporties
    private let router: BaseRouter
    private let factory = SearchFactory()
    private var model = ArticleSearchModel() {
        didSet {
            notifyUpdates()
        }
    }
    
    // MARK: - Init
    init(router: BaseRouter) {
        self.router = router
    }
    
    // MARK: - Funcs
    func start() {
        let vc = factory.makeSearchViewController()
        vc.onEvent = { event in
            switch event {
            case .onShowFilter:
                self.showFilterViewController(model: self.model)
            case .onShowSort:
                self.showSortViewController(model: self.model)
            }
        }
        vc.onRequestShow = { article in
            self.onRequestShow?(article)
        }
        router.setRootController(controller: vc)
    }
    
    func notifyUpdates() {
        // TODO: Implement with rx observers
        guard let vc = router.rootViewController?.visibleViewController as? ArticleSearchModelViewController else { return }
        vc.updateModel(model: self.model)
    }
    
    func showFilterViewController(model: ArticleSearchModel) {
        let vc = factory.makeFilterViewController(model: model)
        vc.onEvent = { event in
            switch event {
            case .onShowSectors:
                self.showSectorsViewController(model: self.model)
            case .onUpadte(let model):
                self.model = model
            }
        }
        router.push(controller: vc, isTabBarHidden: true)
    }
    
    func showSectorsViewController(model: ArticleSearchModel) {
        let vc = factory.makeSectorsViewController(model: model)
        vc.onEvent = { event in
            switch event {
            case .onUpadte(let model):
                self.model = model
            }
        }
        router.push(controller: vc, isTabBarHidden: true)
    }
    
    func showSortViewController(model: ArticleSearchModel) {
        let vc = factory.makeSortViewController(model: model)
        vc.onEvent = { event in
            switch event {
            case .onUpdate(let model):
                self.model = model
            }
        }
        router.present(controller: vc)
    }
    
}
