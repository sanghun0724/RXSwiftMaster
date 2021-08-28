//
//  ProtocolExtension.swift
//  PoPtutorial
//
//  Created by sangheon on 2021/08/27.
//

import UIKit
import AVFoundation


//MARK: ContentPresentable
protocol  ContentPresentable: class,Layout { //protocol 상속
    var canPresentContent:Bool { get }
}
extension ContentPresentable {
    var canPresentContent:Bool {
        return true
    }
}

// MARK: Layout
protocol Layout {
    var frame:CGRect { get set }
    mutating func layout(in rect: CGRect)
}

extension Layout {
    mutating func layout(in rect:CGRect) {
        self.frame = rect
    }
}

extension UIImageView:ContentPresentable {} //layout protocol도 사용 (서브클래싱되어있으니)
extension AVPlayerLayer: ContentPresentable {}
extension UILabel:Layout {}

//MARK: MediaContainer
protocol MediaContainer: class { //class 전용 프로토콜 정의 //class대신 anyObject도 가능
    var content:Content? { get set }
    var media:ContentPresentable { get }
    var note:UILabel { get }
    
    var videoLayer:AVPlayerLayer { get }
    var mediaImageView:UIImageView { get }
    
    func contentChanged()
}

extension MediaContainer {
    func contentChanged() {
        guard let content = content else { //model값 없으면
            mediaImageView.isHidden = true
            videoLayer.isHidden = true
            
            mediaImageView.image = nil
            videoLayer.player = nil
            return
        }
        
        switch content.type { //있으면
        case .image:
            mediaImageView.isHidden = false
            videoLayer.isHidden = true
            
            if let image:UIImage = UIImage(contentsOfFile: content.URLString) {
                mediaImageView.image = image
            }
        case .video:
            videoLayer.isHidden = false
            mediaImageView.isHidden = true
            
            let videoURL = NSURL(fileURLWithPath: content.URLString)
            
            let player:AVPlayer = AVPlayer(url: videoURL as URL)
            
            videoLayer.player = player
        }
        note.text = content.note
    }
    
    var media:ContentPresentable {
        get {
            switch content!.type {
            case .image:
                return mediaImageView
            case .video:
                return videoLayer
            }
        }
    }
}

//MARK: ContentContents

protocol ContainContents {
    var contents: [Content] { get }
    var numberOfContents:Int { get }
}

extension ContainContents {
    var contents:[Content] {
        return TimelineContentObject.shared.content
    }
    var numberOfContents:Int {
        return contents.count
    }
}

protocol CanShowDetailView {
    func showDetailView(content:Content)
    var navigationController:UINavigationController? { get }
}

extension CanShowDetailView {
    func showDetailView(content:Content) {
        let detailViewController:DetailViewController = DetailViewController()
        detailViewController.content = content
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
}
