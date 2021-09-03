//
//  DetailViewController.swift
//  PoPtutorial
//
//  Created by sangheon on 2021/08/28.
//

import UIKit
import AVFoundation

class DetailViewController:UIViewController,MediaContainer,UITextFieldDelegate {
    lazy var videoLayer: AVPlayerLayer = AVPlayerLayer()
    lazy var mediaImageView: UIImageView = UIImageView()
   
    
    var note:UILabel = UILabel()
    
    var content:Content? {
        didSet {
            self.contentChanged()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        mediaImageView.layout(in: self.view.bounds)
        videoLayer.layout(in: self.view.bounds)
        print(videoLayer.frame)
        
        mediaImageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        self.view.addSubview(mediaImageView)
        self.view.layer.addSublayer(videoLayer)
        
        var noteFrame:CGRect = self.view.bounds
        noteFrame.origin.y = noteFrame.height / 2 + 200//check please
        noteFrame.size.height = 50
        print(media)
        print("checkcheck")
        note.layout(in: noteFrame)
        note.textAlignment = .center
        note.font = UIFont.systemFont(ofSize: 30)
        self.view.addSubview(note)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if content?.type == .video {
            self.videoLayer.player?.play()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if content?.type == .video {
            self.videoLayer.player?.pause()
            self.videoLayer.player = nil
        }
    }
}

extension UITextFieldDelegate {
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        print("hi")
    }
}
