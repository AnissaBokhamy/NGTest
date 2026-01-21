//
//  FiltersViewModel.swift
//  NGTest
//
//  Created by Anissa Bokhamy on 2026-01-20.
//  Copyright © 2026 Nuglif. All rights reserved.
//

import Foundation

class FiltersViewModel: ObservableObject {

    @Published var filters: [FilterViewModel]
    var shouldDisplayRemoveFilterButton: Bool {
        filters.contains(where: { $0.isEnabled })
    }

    init(filters: [FilterViewModel]) {
        self.filters = filters
    }

    func select(filter: String) {
        guard let selectedFilter = filters.first(where: { $0.text == filter} ) else { return }
        filters.forEach { filter in
            filter.isEnabled = filter.text == selectedFilter.text
        }
    }
}

class FilterViewModel: ObservableObject {
    @Published var text: String
    @Published var isEnabled: Bool

    init(text: String, isEnabled: Bool = false) {
        self.text = text
        self.isEnabled = isEnabled
    }
}
