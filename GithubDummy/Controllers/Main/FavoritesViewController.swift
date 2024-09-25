//
//  FavoritesViewController.swift
//  GithubDummy
//
//  Created by MacBook AIR on 25/09/2024.
//
import UIKit
import JGProgressHUD

class FavoritesViewController: UIViewController {

    private let spinner = JGProgressHUD(style: .dark)

    private let homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GitHubFollowerCell.self, forCellReuseIdentifier: GitHubFollowerCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .systemBackground
        return tableView
    }()

    public let gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    var networkManager: NetworkManager
    var homeData: [Repository] = UserDefaults().bookMarkUsers()
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        configureDelegates()
        configureConstraints()
        configureBackgroundColor()
        loadDataAsync()
        configureNavigation()
        configureAction()
    }

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  override func viewDidAppear(_ animated: Bool) {
    HapticManager.shared.vibrate(for: .success)
    fetchData()
  }

    func configureAction() {
        refreshControl.addTarget(self, action: #selector(didrefresh), for: .valueChanged)
        homeTableView.addSubview(refreshControl)
    }

    @objc func didrefresh(send: UIRefreshControl) {
        loadDataAsync()
    }

    func loadDataAsync() {
        fetchData()
    }

    func fetchData() {
      homeData = UserDefaults().bookMarkUsers()
      homeTableView.reloadData()
        if !homeData.isEmpty {
            refreshControl.endRefreshing()
            spinner.dismiss()
            gifImageView.image = UIImage.gifImageWithName("created")
        } else {
            spinner.dismiss()
            refreshControl.endRefreshing()
            gifImageView.image = UIImage.gifImageWithName("created")
        }
    }

    func configureBackgroundColor() {
        view.backgroundColor = .systemBackground
        homeTableView.backgroundColor = .systemBackground
    }

    func configureNavigation() {
        title = "Favorites"
        navigationItem.largeTitleDisplayMode = .always
    }

    func addSubview() {
        view.addSubview(homeTableView)
        view.addSubview(gifImageView)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            homeTableView.topAnchor.constraint(equalTo: view.topAnchor),
            homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            gifImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gifImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gifImageView.widthAnchor.constraint(equalToConstant: 40),
            gifImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func configureDelegates() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if homeData.count > 0 {
            gifImageView.layer.opacity = 0
        } else {
            gifImageView.layer.opacity = 1
        }
        return homeData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GitHubFollowerCell.identifier, for: indexPath) as? GitHubFollowerCell else {
            return UITableViewCell()
        }
        cell.configure(homeData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let userUrl = homeData[indexPath.row].owner?.url else { return }
        let vc = DetailViewController(userUrl: userUrl, networkManager: networkManager)
        vc.respository = homeData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Swipe to Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove from data source
            homeData.remove(at: indexPath.row)
            UserDefaults().deleteUser(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
