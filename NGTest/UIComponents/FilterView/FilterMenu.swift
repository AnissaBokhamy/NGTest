//
//  FilterMenu.swift
//  NGTest
//
//  Created by Anissa Bokhamy on 2026-01-20.
//  Copyright © 2026 Nuglif. All rights reserved.
//

import UIKit

extension UIMenu {

    static func createFilterMenu(
        from viewModel: FiltersViewModel,
        removeFilterHandler: @escaping ()-> Void,
        filteringHandler: @escaping (String) -> Void
    ) -> UIMenu {
        let filtersActions = Self.filtersActions(viewModel: viewModel, filteringHandler: filteringHandler)
        if viewModel.shouldDisplayRemoveFilterButton {
            return UIMenu(children: [
                UIAction.createRemoveFilterAction(handler: { _ in removeFilterHandler() }),
                UIMenu(options: .displayInline, children: filtersActions),
            ])
        } else {
            return UIMenu(children: filtersActions)
        }
    }

    private static func filtersActions(viewModel: FiltersViewModel, filteringHandler: @escaping (String) -> Void) -> [UIAction] {
        viewModel.filters.compactMap({ filter in
            UIAction.createFilterAction(
                viewModel: filter,
                handler: { _ in
                    filteringHandler(filter.text)
                    viewModel.select(filter: filter.text)
                }
            )
        })
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

    static func createRemoveFilterAction(handler: @escaping UIActionHandler) -> UIAction {
        UIAction(title: "Remove filter", image: UIImage(systemName: "xmark.app"), handler: handler)
    }
}
