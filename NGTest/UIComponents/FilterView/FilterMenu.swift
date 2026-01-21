//
//  FilterMenu.swift
//  NGTest
//
//  Created by Anissa Bokhamy on 2026-01-20.
//  Copyright © 2026 Nuglif. All rights reserved.
//

import UIKit

extension UIMenu {

    static func createFilterMenu(from viewModel: FiltersViewModel, filteringHandler: @escaping (String) -> Void) -> UIMenu {
        UIMenu(children:
                viewModel.filters.compactMap({ filter in
            UIAction.createFilterAction(
                viewModel: filter,
                handler: { _ in
                    filteringHandler(filter.text)
                    viewModel.select(filter: filter.text)
                }
            )
        })
        )
    }
}

extension UIAction {
    static func createFilterAction(viewModel: FilterViewModel, handler: @escaping UIActionHandler) -> UIAction {
        UIAction(
            title: viewModel.text,
            image: viewModel.isEnabled ? UIImage(systemName: "checkmark") : nil,
            handler: handler
        )
    }
}
