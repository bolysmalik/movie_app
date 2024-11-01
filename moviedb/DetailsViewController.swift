

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    
    public var movieId: Int?
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Title"
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Title"
        return label
    }()
    
    private let genre1View: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let genre1Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "label"
        return label
    }()
    
    private let genre2View: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let genre2Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "label"
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
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Title"
        return label
    }()
    
    private let person1View: UIView = {
        let view = UIView()
        return view
    }()
    private let person1ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let person1Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Title"
        label.numberOfLines = 0
        return label
    }()
    
    private let person2View: UIView = {
        let view = UIView()
        return view
    }()
    private let person2ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let person2Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Title"
        label.numberOfLines = 0
        return label
    }()
    
    private var firstActorId: Int?
    private var secondActorId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let movieService = MovieService()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
        guard let movieId = movieId else {
            print("Error: movieId is nil")
            return
        }
        
        Task {
            do {
                let movie = try await movieService.fetchMovieDetailData(movieId: movieId)
                print("Fetched movie details: \(movie)")
                
                DispatchQueue.main.async {
                    self.configure(movieDetails: movie)
                }
                
            } catch {
                print("Error fetching movie details: \(error)")
            }
        }
        
        movieService.fetchMovieCredits(movieId: movieId) { actors, error in
            if let error = error {
                print("Error fetching movie credits: \(error)")
            } else if let actors = actors {
                self.configure(actors: actors)
                self.firstActorId = actors[0].id
                self.secondActorId = actors[1].id
                for actor in actors {
                    
                    print("Actor: \(actor.name), Character: \(actor.id)")
                }
            }
        }
    }
    
    private func setupViews() {
        
        [customImageView, titleLabel, releaseDateLabel, genre1View, genre1Label, genre2View, genre2Label, overviewView, castLabel, person1View, person2View].forEach { item in
            contentView.addSubview(item)
        }
        person1View.addSubview(person1Label)
        person1View.addSubview(person1ImageView)
        person2View.addSubview(person2Label)
        person2View.addSubview(person2ImageView)
        genre1View.addSubview(genre1Label)
        genre2View.addSubview(genre2Label)
        overviewView.addSubview(overviewTitleLabel)
        overviewView.addSubview(overviewInformationLabel)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(person1ViewTapped))
            person1View.addGestureRecognizer(tapGesture)
            person1View.isUserInteractionEnabled = true
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(person2ViewTapped))
            person2View.addGestureRecognizer(tapGesture2)
            person2View.isUserInteractionEnabled = true
    }
    
    @objc func person1ViewTapped() {
        let vc = ActorDitailViewController()
        vc.personId = firstActorId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func person2ViewTapped() {
        let vc = ActorDitailViewController()
        vc.personId = secondActorId
        navigationController?.pushViewController(vc, animated: true)
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
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(customImageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview().offset(16)
        }
        
        genre1View.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        
        genre1Label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        genre2Label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        genre2View.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(16)
            make.leading.equalTo(genre1View.snp.trailing).offset(16)
            make.height.equalTo(40)
        }
        
        overviewView.snp.makeConstraints { make in
            make.top.equalTo(genre2View.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        overviewTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        overviewInformationLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        castLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        person1View.snp.makeConstraints { make in
            make.top.equalTo(castLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo((view.frame.width / 2) - 32)
        }
        
        person1ImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
            make.size.equalTo(50)
        }
        
        person1Label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(person1ImageView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        person2View.snp.makeConstraints { make in
            make.top.equalTo(castLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo((view.frame.width / 2) - 32)
        }
        person2ImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
            make.size.equalTo(50)
        }
        person2Label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(person2ImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }
    }
    
    private func configure(movieDetails: Movie) {
        guard let posterPath = movieDetails.posterPath else { return }
        let imageURLString = "https://image.tmdb.org/t/p/w500" + posterPath
        
        guard let imageURL = URL(string: imageURLString) else { return }
        
        print("Image URL: \(imageURL)")
        
        customImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "xmark"))
        titleLabel.text = movieDetails.title
        releaseDateLabel.text = "Release date: \(movieDetails.releaseDate ?? "")"
        genre1Label.text = movieDetails.genres?[0].name
        genre2Label.text = movieDetails.genres?[1].name
        overviewTitleLabel.text = movieDetails.originalTitle
        overviewInformationLabel.text = movieDetails.overview
        castLabel.text = "Cast"
    }
    
    private func configure(actors: [Actor]) {
        guard let posterPath = actors[0].profilePath, let posterPath2 = actors[1].profilePath else { return }
        let imageURLString = "https://image.tmdb.org/t/p/w500" + posterPath
        let imageURLString2 = "https://image.tmdb.org/t/p/w500" + posterPath2
        
        guard let imageURL = URL(string: imageURLString), let imageURL2 = URL(string: imageURLString2) else { return }
        DispatchQueue.main.async {
            self.person1ImageView.sd_setImage(with: imageURL)
            self.person1Label.text = actors[0].name
            self.person2ImageView.sd_setImage(with: imageURL2)
            self.person2Label.text = actors[1].name
        }
        
    }
    
}
