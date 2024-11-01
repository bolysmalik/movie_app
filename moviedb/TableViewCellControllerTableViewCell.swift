//
//  TableViewCellControllerTableViewCell.swift
//  moviedb
//
//  Created by Bolys Malik on 13.11.2024.
//

import UIKit
import SnapKit
import SDWebImage


class MovieTableViewCell: UITableViewCell {
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let customLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(customImageView)
        contentView.addSubview(customLabel)
        
        let width = contentView.bounds.width
        
        customImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo((width * 4) / 3 + 32)
        }
        
        customLabel.snp.makeConstraints { make in
            make.top.equalTo(customImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customImageView.layer.cornerRadius = 30
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func configure(movieData: MovieDetail) {
        customLabel.text = movieData.title
        guard let posterPath = movieData.posterPath else { return }
        let imageURLString = "https://image.tmdb.org/t/p/w500" + posterPath
        
        guard let imageURL = URL(string: imageURLString) else { return }
        
        print("Image URL: \(imageURL)")
        
        customImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "xmark"))
    }

}
