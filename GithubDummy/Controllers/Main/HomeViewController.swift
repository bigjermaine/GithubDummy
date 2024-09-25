//
//  HomeViewController.swift
//  GithubDummy
//
//  Created by MacBook AIR on 25/09/2024.
//
import UIKit
import JGProgressHUD

class HomeViewController: UIViewController {

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
  var homeData: [Repository] = []
  var refreshControl = UIRefreshControl()

  private var currentPage: Int = 1
  private var hasMoreData: Bool = true
  private var offlineMode: Bool = false

  init(networkManager: NetworkManager) {
    self.networkManager = networkManager
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    configureDelegates()
    configureConstraints()
    configureBackgroundColor()
    loadDataAsync()
    configureNavigation()
    configureAction()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    HapticManager.shared.vibrate(for: .success)
  }

  private func setupViews() {
    view.addSubview(homeTableView)
    view.addSubview(gifImageView)
  }

  private func configureDelegates() {
    homeTableView.delegate = self
    homeTableView.dataSource = self
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      homeTableView.topAnchor.constraint(equalTo: view.topAnchor),
      homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      gifImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      gifImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      gifImageView.widthAnchor.constraint(equalToConstant: 50),
      gifImageView.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  private func configureBackgroundColor() {
    view.backgroundColor = .systemBackground
    homeTableView.backgroundColor = .systemBackground
  }

  private func configureNavigation() {
    title = "Github Followers"
    navigationItem.largeTitleDisplayMode = .always
  }

  private func configureAction() {
    refreshControl.addTarget(self, action: #selector(didrefresh), for:UIControl.Event.valueChanged)
    homeTableView.addSubview(refreshControl)
  }

  @objc private  func didrefresh(send:UIRefreshControl) {
    currentPage = 1
    hasMoreData = true
    loadDataAsync()
  }

  private func loadDataAsync() {
    //guard hasMoreData else { return }
    Task {
      await fetchData(page: currentPage)
    }
  }

  private func fetchData(page: Int) async {
    spinner.show(in: view)
    do {
      let newData = try await networkManager.fetchCities(page: page)
      if newData.isEmpty {
        hasMoreData = false
      }
      homeData.append(contentsOf: newData)
      refreshControl.endRefreshing()
      homeTableView.reloadData()
      offlineMode = false
      storeOfflineData()
      spinner.dismiss()
    } catch let error {
      handleFetchError(error)
      refreshControl.endRefreshing()

    }
  }

  private func handleFetchError(_ error: Error) {
    gifImageView.image = UIImage.gifImageWithName("checking")
    homeData = UserDefaults().offlineUsers()

    if !homeData.isEmpty {
      Alert.showBasic(title: "Data Using Offline Mode", message: "Pull To Refresh..", vc: self)
      offlineMode = true
    } else {
      Alert.showBasic(title: "Error", message: error.localizedDescription, vc: self)
    }
    refreshControl.endRefreshing()
    homeTableView.reloadData()
    spinner.dismiss()

  }

  private func storeOfflineData() {
    let usersToStore = Array(homeData.prefix(20)) // Get up to 20 users
    for user in usersToStore {
      UserDefaults().dowloadOfflineUser(user: user)
    }
  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    gifImageView.layer.opacity = homeData.isEmpty ? 1 : 0
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
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row ==  homeData.count - 1 && hasMoreData && !offlineMode {
      currentPage += 1
      loadDataAsync()
    }
  }

}
