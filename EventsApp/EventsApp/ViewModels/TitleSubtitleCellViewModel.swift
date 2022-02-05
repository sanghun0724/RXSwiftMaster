//
//  TitleSubtitleCellViewModel.swift
//  EventsApp
//
//  Created by sangheon on 2022/02/02.
//


final class TitleSubTitleCellViewModel {
    let title:String
    private(set) var subtitle:String
    let placeholder:String
    
    init(title:String,subtitle:String,placeholder:String) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
    }
}
