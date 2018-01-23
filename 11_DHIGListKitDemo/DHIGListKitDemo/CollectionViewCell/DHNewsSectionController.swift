//
//  DHNewsSectionController.swift
//  DHIGListKitDemo
//
//  Created by zipingfang on 2018/1/23.
//  Copyright © 2018年 aiden. All rights reserved.
//

import Foundation
import IGListKit

final class DHNewsSectionController: ListSectionController {
    override func numberOfItems() -> Int {
        return 5
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 50)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionContext?.dequeueReusableCell(withNibName: "DHNewsTopCollectionViewCell", bundle: nil, for: self, at: index) as! DHNewsTopCollectionViewCell
            return cell
        case 1:
            let cell = collectionContext?.dequeueReusableCell(withNibName: "DHNewsContentCollectionViewCell", bundle: nil, for: self, at: index) as! DHNewsContentCollectionViewCell
            cell.titleLabel.text = "123"
            cell.contentLabel.text = "nhiogqwmdwnegienwgiqwmiofmiwnfunqwurnwuirnwnr"
            return cell
            
        case 2:
//            let cell = collectionContext?.dequeueReusableCell(withNibName: "DHNewsImgsCollectionViewCell", bundle: nil, for: self, at: index) as! DHNewsImgsCollectionViewCell
//            return cell
            
//            let cell = collectionContext?.dequeueReusableCell(withNibName: "DHNewsImgCollectionViewCell", bundle: nil, for: self, at: index) as! DHNewsImgCollectionViewCell
//            return cell
            
            let cell = collectionContext?.dequeueReusableCell(withNibName: "DHNewsVedioCollectionViewCell", bundle: nil, for: self, at: index) as! DHNewsVedioCollectionViewCell
            return cell
            
//            let cell = collectionContext?.dequeueReusableCell(withNibName: "DHNewsAudioCollectionViewCell", bundle: nil, for: self, at: index) as! DHNewsAudioCollectionViewCell
//            return cell
            
//            let cell = collectionContext?.dequeueReusableCell(withNibName: "DHNewsAnswerCollectionViewCell", bundle: nil, for: self, at: index) as! DHNewsAnswerCollectionViewCell
//            return cell
            
//            let cell = collectionContext?.dequeueReusableCell(withNibName: "DHNewsLinkCollectionViewCell", bundle: nil, for: self, at: index) as! DHNewsLinkCollectionViewCell
//            return cell
            
        case 3:
            let cell = collectionContext?.dequeueReusableCell(withNibName: "DHNewsBottomCollectionViewCell", bundle: nil, for: self, at: index) as! DHNewsBottomCollectionViewCell
            return cell
        case 4:
            let cell = collectionContext?.dequeueReusableCell(withNibName: "DHSeparatorCollectionViewCell", bundle: nil, for: self, at: index) as! DHSeparatorCollectionViewCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    override func didUpdate(to object: Any) {
        
    }
    
    override func didSelectItem(at index: Int) {
        
    }
}
