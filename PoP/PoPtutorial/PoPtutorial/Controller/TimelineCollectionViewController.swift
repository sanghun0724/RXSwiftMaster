//
//  TimelineCollectionViewController.swift
//  PoPtutorial
//
//  Created by sangheon on 2021/08/27.
//

import UIKit

private let reuseIdentifier = "CollectionCell"

class TimelineCollectionViewController:UICollectionViewController ,ContainContents ,CanShowDetailView{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = timelineTitle
        self.collectionView.register(TimelineCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    //MARK: UICollectionViewDatasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfContents
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:TimelineCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TimelineCollectionViewCell
        cell.content = contents[indexPath.row]
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetailView(content: contents[indexPath.row])
    }
    
    
}
