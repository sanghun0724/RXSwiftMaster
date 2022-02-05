//
//  UIColor.swift
//  EventsApp
//
//  Created by sangheon on 2022/02/02.
//

import UIKit

extension UIColor {
    static let primary = UIColor(red: 0/255, green: 39/255, blue: 255/255, alpha: 0.6)
}


extension UIViewController {
    static let safetyArea: UIView = {
             let v = UIView()
             v.backgroundColor = .black
             return v
      }()
    
    func setUI() {
        UIViewController.safetyArea.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(UIViewController.safetyArea)
          
          if #available(iOS 11, *) {
              let guide = view.safeAreaLayoutGuide
              UIViewController.safetyArea.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
              UIViewController.safetyArea.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
              UIViewController.safetyArea.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
              UIViewController.safetyArea.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
              
          } else {
              UIViewController.safetyArea.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
              UIViewController.safetyArea.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
              UIViewController.safetyArea.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
              UIViewController.safetyArea.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
          }
        view.setNeedsUpdateConstraints()
}
}
