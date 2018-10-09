//
//  SchoolCell.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import SnapKit

final class SchoolCell: UICollectionViewCell {
    
    static let titleInset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.icon.width + Styles.Sizes.columnSpacing,
        bottom: Styles.Text.secondary.preferredFont.lineHeight + 2*Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )

    private let borough  = UILabel()
    private let name     = UILabel()
    private let location = UILabel()
    private let phone    = UILabel()


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        contentView.clipsToBounds = true
        
        contentView.addSubview(borough)
        contentView.addSubview(name)
        contentView.addSubview(location)
        contentView.addSubview(phone)
        
        borough.textAlignment  = .left
        borough.textColor      = Styles.Colors.Blue.medium.color
        borough.font           = Styles.Text.borough.font(contentSizeCategory: .preferred)

        name.textAlignment     = .left
        name.numberOfLines     = 0
        name.font              = Styles.Text.name.font(contentSizeCategory: .preferred)

        location.textAlignment = .left
        location.font          = Styles.Text.location.font(contentSizeCategory: .preferred)

        phone.textAlignment    = .left
        phone.font             = Styles.Text.phone.font(contentSizeCategory: .preferred)

        borough.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(SchoolCell.titleInset.left)
            make.right.equalTo(contentView.snp.right).offset(-SchoolCell.titleInset.left)
            make.top.equalTo(contentView.snp.top).offset(SchoolCell.titleInset.top*2)
        }
    
        name.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(SchoolCell.titleInset.left)
            make.right.equalTo(contentView.snp.right).offset(-SchoolCell.titleInset.left)
            make.top.equalTo(borough.snp.bottom).offset(SchoolCell.titleInset.top)
        }
        
        location.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(SchoolCell.titleInset.left)
            make.right.equalTo(contentView.snp.right).offset(-SchoolCell.titleInset.left)
            make.top.equalTo(name.snp.bottom).offset(SchoolCell.titleInset.top)
        }
        
        phone.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(SchoolCell.titleInset.left)
            make.right.equalTo(contentView.snp.right).offset(-SchoolCell.titleInset.left)
            make.top.equalTo(location.snp.bottom).offset(SchoolCell.titleInset.top)
        }
        
        addBorder(.bottom, left: Styles.Sizes.gutter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets(bounds: self.bounds)
    }
    
    func configure(viewModel: SchoolViewModel) {
        self.borough.text  = viewModel.borough
        self.name.text     = viewModel.name
        self.location.text = viewModel.location
        self.phone.text    = viewModel.phone
        setNeedsLayout()
    }
    
    func layoutContentViewForSafeAreaInsets(bounds: CGRect) {
        let insets: UIEdgeInsets = safeAreaInsets
        contentView.frame = CGRect(
            x: insets.left,
            y: bounds.minY,
            width: bounds.width - insets.left - insets.right,
            height: bounds.height
        )
    }
}
