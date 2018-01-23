//
//  DHSectionController.swift
//  DHIGListKitDemo
//
//  Created by aiden on 2018/1/14.
//  Copyright © 2018年 aiden. All rights reserved.
//

import Foundation
import IGListKit

class DHTitleModel: NSObject {
    var title: String
    init(title: String) {
        self.title = title
    }
}

extension DHTitleModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return title as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? DHTitleModel else { return false }
        return title == object.title
    }
}

final class DHTitleSectionController: ListSectionController {

    var model: DHTitleModel?
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 50)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: "DHTitleCollectionViewCell", bundle: nil, for: self, at: index) as! DHTitleCollectionViewCell
        cell.titleLabel.text = "123"
        return cell
    }

    override func didUpdate(to object: Any) {
        self.model = object as? DHTitleModel
    }

    override func didSelectItem(at index: Int) {
        
    }
}
