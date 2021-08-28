//
//  CollectionVIewController.swift
//  PoPtutorial
//
//  Created by sangheon on 2021/08/15.
//

import UIKit
import AVFoundation

class TimelineCollectionViewCell:UICollectionViewCell,MediaContainer {
    
    lazy var videoLayer:AVPlayerLayer = AVPlayerLayer()
    lazy var mediaImageView:UIImageView = UIImageView()
    
    var note:UILabel = UILabel()
    
    var content:Content? {
        didSet {
            self.contentChanged()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        var mediaRect:CGRect = self.bounds
        mediaRect.size.width -= 10
        mediaRect.size.height -= 40
        mediaRect.origin.x += 5
        mediaRect.origin.y += 5
        
        mediaImageView.layout(in: mediaRect)
        videoLayer.layout(in: mediaRect)
        
        mediaImageView.contentMode = .scaleAspectFit
        
        self.addSubview(mediaImageView)
        self.layer.addSublayer(videoLayer)
        
        note.textAlignment = .center
        
        var noteRect:CGRect = mediaRect
        noteRect.origin.y = self.bounds.size.height - 30
        noteRect.size.height = 30
        
        note.layout(in: noteRect)
        
        self.addSubview(note)
        
        note.font = UIFont.systemFont(ofSize: 15)
        note.adjustsFontSizeToFitWidth = true
        note.minimumScaleFactor = 0.1
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame:CGRect,content:Content) {
        self.init(frame:frame)
        self.content = content
        contentChanged()
    }//편리한 초기자는 초기화 단계에서 미리 지정된 값을 사용해서 최소한의 입력으로 초기화를 할 수 있도록 해주는 초기자입니다. 편리한 초기자 내에서 반드시 지정 초기자가 호출돼야 합니다.

    
    
    
}
