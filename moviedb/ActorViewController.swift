import UIKit
import SnapKit

class ActorViewController: UIViewController, UITableViewDataSource {

    private let actorDetails = [
        "Name": "John Doe",
        "Biography": "John Doe is a famous actor known for his roles in action movies. He has won several awards for his outstanding performances.",
        "Date of Birth": "January 1, 1980",
        "Nationality": "American"
    ]

    private let actorMovies = [
        "Movie 1: The Adventure",
        "Movie 2: Hero's Journey",
        "Movie 3: Action Packed",
        "Movie 4: The Final Chapter",
        "Movie 5: The Last Stand"
    ]
    
    private let actorProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "actorProfileImage")
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MovieCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
        tableView.dataSource = self
    }
    
    private func setupUI() {
        view.addSubview(actorProfileImageView)
        actorProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(actorProfileImageView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview().inset(20)
        }
        
        tableView.dataSource = self
    }

    // UITableViewDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return actorDetails.count
        } else {
            return actorMovies.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
            
            let detailKeys = Array(actorDetails.keys)
            let detailKey = detailKeys[indexPath.row]
            let detailValue = actorDetails[detailKey]
            
            cell.textLabel?.text = "\(detailKey): \(detailValue ?? "")"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
            
            cell.textLabel?.text = actorMovies[indexPath.row]
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            print("Movie tapped: \(actorMovies[indexPath.row])")
        }
    }
}
