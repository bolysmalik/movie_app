import UIKit
import SnapKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {
    
    private let titleLabel = UILabel()
    private let items = ["Action", "Adventure", "Action", "Action", "Adventure"]

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let tableItems: [TableItem] = [
        TableItem(imageName: "image1", text: "Image 1"),
        TableItem(imageName: "image2", text: "Image 2"),
        TableItem(imageName: "image3", text: "Image 3"),
        TableItem(imageName: "image4", text: "Image 4"),
        TableItem(imageName: "image5", text: "Image 5")
    ]
    
    private var movieList: [MovieDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let movieService = MovieService()
        setupTitleLabel()
        setupCollectionView()
        setupTableView()
        
        movieService.fetchMovies { welcome, error in
            if let error = error {
                print("Failed to fetch movies: \(error)")
            } else if let welcome = welcome {
                self.movieList = welcome.results
                print("Page: \(welcome.page)")
                for movie in welcome.results {
                    print("Title: \(movie.title), Release Date: \(movie.posterPath)")
                }
                
                // Make sure to update the UI on the main thread
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Uncharted"
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // UICollectionView DataSource & Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        let text = items[indexPath.item]
        cell.configure(with: text)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = items[indexPath.item]
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width + 20
        return CGSize(width: width, height: 30)
    }
    
    // UITableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell
        
        let item = movieList[indexPath.row]
        cell?.configure(movieData: item)
        cell?.imageView?.contentMode = .scaleAspectFit
        cell?.imageView?.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailsViewController()
        nextVC.movieId = movieList[indexPath.row].id
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

struct TableItem {
    let imageName: String
    let text: String
}
