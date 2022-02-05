//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by sangheon on 2022/02/02.
//

import UIKit

final class AddEventViewModel {
    
    let title = "Add"
    var onUpdate:() -> Void = {}
    
    enum Cell {
        case titleSubtitle(TitleSubTitleCellViewModel)
        case titleImage
    }
    
    private(set) var cells:[AddEventViewModel.Cell] = []
    var coordinator:AddEventCoordinator?
    
    func viewDidLoad() {
        cells = [
            .titleSubtitle(TitleSubTitleCellViewModel(title: "Name", subtitle: "", placeholder: "Add a name")),
            .titleSubtitle(TitleSubTitleCellViewModel(title: "Date", subtitle: "", placeholder: "Select a date"))
        ]
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
        print("disppear work")
    }
    
    func numberofRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath:IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
     //extreact info from view models and save in core data
        print("tappedDone")
    }
}


