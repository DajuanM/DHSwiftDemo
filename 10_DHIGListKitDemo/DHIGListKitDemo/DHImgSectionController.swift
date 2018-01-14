//
//  DHImgSectionController.swift
//  DHIGListKitDemo
//
//  Created by aiden on 2018/1/14.
//  Copyright © 2018年 aiden. All rights reserved.
//

import Foundation
import IGListKit

class DHImgModel: NSObject {
    var color: UIColor
    init(color: UIColor) {
        self.color = color
    }
}

extension DHImgModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return color as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
}

class DHImgSectionController: ListSectionController {
    var model: DHImgModel?
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 80)
    }


    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: "DHImgCollectionViewCell", bundle: nil, for: self, at: index) as! DHImgCollectionViewCell
        cell.imgView.backgroundColor = model?.color
        return cell
    }

    override func didUpdate(to object: Any) {
        self.model = object as? DHImgModel
    }

    override func didSelectItem(at index: Int) {

    }
}
