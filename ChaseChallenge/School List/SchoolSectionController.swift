//
//  SchoolSectionController.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

import Foundation
import IGListKit

protocol SchoolSectionControllerDelegate: class {
    func didSelect(SchoolSectionController: SchoolSectionController, viewModel: SchoolViewModel)
}

extension String {
    func height(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font : font], context: nil)
        return actualSize.height
    }
}

final class SchoolSectionController: ListGenericSectionController<SchoolViewModel> {
    
    weak var delegate: SchoolSectionControllerDelegate?
    
    init(delegate: SchoolSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width,
            let object = object else {
                fatalError("Missing context")
        }
        
        
        return CGSize(
            width: width,
            height: object.cellHeight
        )
    }
    
  
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SchoolCell.self, for: self, at: index) as? SchoolCell else {
            fatalError("Missing context or wrong cell type")
        }
        guard let object = object else { fatalError() }
        cell.configure(viewModel: object)
//        cell.configure(viewModel: object, height: sizeForItem(at: index).height)
      
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        collectionContext?.deselectItem(at: index, sectionController: self, animated: true)
        
        guard let object = object else { return }
        delegate?.didSelect(SchoolSectionController: self, viewModel: object)
    }
}
