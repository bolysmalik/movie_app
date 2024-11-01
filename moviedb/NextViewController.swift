import UIKit
import SnapKit

class NextViewController: UIViewController, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate {
    
    private let movieImages = ["moviePoster", "screenshot1", "screenshot2", "screenshot3"]
    private let movieDetails = [
        "Title": "Movie Title",
        "Release Date": "2024",
        "Rating": "8.7/10",
        "Overview": "This is a brief overview of the movie. The movie is a thrilling adventure about a hero who saves the world in the most dramatic way possible. Get ready for an action-packed experience!",
        "Cast": "Actor 1, Actor 2, Actor 3"
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 300)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        return collectionView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        
        tableView.dataSource = self
        tableView.delegate = self  // Set the delegate for row selection
    }
    
    private func setupUI() {
        let mainStackView = UIStackView(arrangedSubviews: [collectionView, tableView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 20
        mainStackView.alignment = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        
        tableView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: movieImages[indexPath.item])
        cell.contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        
        let detailKeys = Array(movieDetails.keys)
        let detailKey = detailKeys[indexPath.row]
        let detailValue = movieDetails[detailKey]
        
        cell.textLabel?.text = "\(detailKey): \(detailValue ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Check if the first row was tapped
        if indexPath.row == 4 {
            let actorVC = ActorViewController()
            navigationController?.pushViewController(actorVC, animated: true)
        }
    }
}
