//
//  DetailsViewController.swift
//  moviedb
//
//  Created by Yerassyl Yerkin on 14.11.2024.
//

import UIKit
import SnapKit

class ActorDitailViewController: UIViewController {
    
    public var personId: Int?
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Title"
        return label
    }()
    
    private let bornDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Title"
        label.numberOfLines = 0
        return label
    }()
    
    private let overviewView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Title"
        return label
    }()
    private let overviewInformationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Title"
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let movieService = MovieService()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
        guard let personId = personId else {
            print("Error: movieId is nil")
            return
        }
        
        Task {
            do {
                let person = try await movieService.fetchPersonDetail(personId: personId)
                print("Name: \(person.name)")
                print("Biography: \(person.biography ?? "No biography available")")
                print("Place of Birth: \(person.placeOfBirth)")
                
                configure(person: person)
                if let profilePath = person.profilePath {
                    let profileImageUrl = "https://image.tmdb.org/t/p/w500\(profilePath)"
                    print("Profile Image URL: \(profileImageUrl)")
                }
                
            } catch {
                print("Error fetching person details: \(error)")
            }
        }
    }
    
    private func setupViews() {
        
        [customImageView, nameLabel, bornDateLabel, overviewView].forEach { item in
            contentView.addSubview(item)
        }
        overviewView.addSubview(overviewTitleLabel)
        overviewView.addSubview(overviewInformationLabel)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        let width = view.bounds.width
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        customImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo((width * 4) / 3 + 32)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(customImageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        bornDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        overviewView.snp.makeConstraints { make in
            make.top.equalTo(bornDateLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        overviewTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        overviewInformationLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    private func configure(person: Person) {
        guard let posterPath = person.profilePath else { return }
        let imageURLString = "https://image.tmdb.org/t/p/w500" + posterPath
        
        guard let imageURL = URL(string: imageURLString) else { return }
        
        print("Image URL: \(imageURL)")
        
        customImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "xmark"))
        nameLabel.text = person.name
        bornDateLabel.text = "Born \(String(describing: person.birthday))\n \(person.placeOfBirth)"
        overviewTitleLabel.text = "Bio"
        overviewInformationLabel.text = person.biography
    }
    
}
