//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by sangheon on 2022/02/02.
//

import Foundation

final class EventListViewModel {
    
    let title = "Events"
    var coordinator: EventListCoordinator?
    
    func didTapRightButton() {
        coordinator?.startAddEvent()
    }
}
