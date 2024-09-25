//
//  DetailViewController.swift
//  GithubDummy
//
//  Created by MacBook AIR on 25/09/2024.
//

import UIKit
import JGProgressHUD
import SDWebImage
class DetailViewController: UIViewController {

  private let spinner = JGProgressHUD(style: .dark)

  private let scrollView: UIScrollView  = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.isScrollEnabled = true
    scrollView.showsVerticalScrollIndicator = true
    scrollView.showsHorizontalScrollIndicator = false
    return scrollView
  }()

  private let  profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(systemName: "person.fill")
    imageView.layer.cornerRadius = 31
    imageView.backgroundColor = .green
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()


  private let nameLabel :UILabel  = {
    let label = UILabel()
    label.textColor = .label
    label.textAlignment = .center
    label.font =  .systemFont(ofSize: 30, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = ""
    label.clipsToBounds = true
    return label
  }()

  private let followersLabel :UILabel  = {
    let label = UILabel()
    label.textColor = .label
    label.textAlignment = .center
    label.font =  .systemFont(ofSize: 18, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.clipsToBounds = true
    return label
  }()

  private let followingLabel :UILabel  = {
    let label = UILabel()
    label.textColor = .label
    label.textAlignment = .center
    label.font =  .systemFont(ofSize: 18, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.clipsToBounds = true
    return label
  }()

  private let bioLabel :UILabel  = {
    let label = UILabel()
    label.textColor = .label
    label.textAlignment = .left
    label.font =  .systemFont(ofSize: 16, weight: .regular)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = ""
    label.clipsToBounds = true
    return label
  }()

  public let gifImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()


  public let favouriteButton:UIButton = {
    let button = UIButton()
    button.setTitle("Add Favorite", for: .normal)
    button.setImage(UIImage(systemName: "star.fill"), for: .normal)
    button.titleLabel?.font = .systemFont(ofSize:12, weight: .bold)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .systemYellow
    button.setTitleColor(.black, for: .normal)
    button.layer.cornerRadius = 4
    button.layer.masksToBounds = true
    return button
  }()



  var userUrl:String

  var networkManager:NetworkManager
  

  var respository:Repository?
  var userDetail:User?

  private let userDetailsView = UserDetailsView()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    configureBackgroundColor()
    addSubviews()
    configureConstraints()
    loadDataAsync()
    addAction()
    hideDowloadButton()
    setTabbarToNil()
  }


  init(userUrl: String,networkManager:NetworkManager) {
    self.userUrl = userUrl
    self.networkManager = networkManager
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addAction() {
    favouriteButton.addTarget(self, action: #selector(didTapAddFavourite), for: .touchUpInside)
  }

  private func setTabbarToNil() {
      tabBarController?.tabBar.items?[1].badgeValue = nil
  }
  @objc func didTapAddFavourite() {

    guard let respository = respository else {
      HapticManager.shared.vibrate(for: .error)
      Alert.showBasic(title: "Alert", message: "Error Adding Favourite", vc: self)
      return
    }
    HapticManager.shared.vibrate(for: .success)
    UserDefaults().bookMarkUser(user: respository)
    tabBarController?.viewControllers?[1].tabBarItem.badgeValue = "New"
    favouriteButton.isHidden = true
    Alert.showBasic(title: "Success", message: "Favourite Added", vc: self)

  }
  func loadDataAsync() {
    Task {
      await fetchData(url: userUrl)
    }
  }

  func hideDowloadButton() {
    let savedPodcasts =  UserDefaults().bookMarkUsers()
    if savedPodcasts.firstIndex(where: { $0.id ==  respository?.id }) != nil {
      favouriteButton.isHidden = true
    } else {
      favouriteButton.isHidden = false
    }
  }

  func fetchData(url:String) async {
    do {
      userDetail =  try await networkManager.fetchCities(url: url)
      spinner.dismiss()
      loadData()
      gifImageView.layer.opacity = 0
      favouriteButton.layer.opacity = 1
    }catch let error {
      Alert.showBasic(title: "Alert", message: error.localizedDescription, vc: self)
      gifImageView.image = UIImage.gifImageWithName("checking")
      gifImageView.layer.opacity = 1
      favouriteButton.layer.opacity = 0
    }

  }
  func loadData() {
    nameLabel.text = userDetail?.name
    bioLabel.text = "Bio \(userDetail?.bio ?? "N/A")"
    followingLabel.text = "\(userDetail?.following ?? 0)\nFollowing"
    followersLabel.text = "\(userDetail?.followers ?? 0)\nFollowers"
    guard let userDetail = userDetail else {return}
    userDetailsView.configure(with: userDetail)
    setImage()
  }

  func setImage() {
    guard let url = URL(string: userDetail?.avatarUrl ?? "") else {
      profileImageView.image = UIImage(systemName: "person.fill")
      return
    }
    profileImageView.sd_setImage(with:url , placeholderImage: UIImage(systemName: "person.fill")) { image, error, cacheType, imageURL in
         if let error = error {
             print("Error loading image: \(error.localizedDescription)")
             self.profileImageView.image = UIImage(systemName: "person.fill")
         }
     }

  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
          scrollView.topAnchor.constraint(equalTo: view.topAnchor),
          scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor), // Maintain the bottom anchor for scrolling


          profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
          profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
          profileImageView.widthAnchor.constraint(equalToConstant: 64),
          profileImageView.heightAnchor.constraint(equalToConstant: 64),

          favouriteButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
          favouriteButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
          favouriteButton.widthAnchor.constraint(equalToConstant:100),
          favouriteButton.heightAnchor.constraint(equalToConstant: 32),



          nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
          nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
          nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),

          followersLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
          followersLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
          followersLabel.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -10),

          followingLabel.topAnchor.constraint(equalTo: followersLabel.topAnchor),
          followingLabel.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 10),
          followingLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),

          bioLabel.topAnchor.constraint(equalTo: followingLabel.bottomAnchor, constant: 10),
          bioLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
          bioLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),

      ])

    NSLayoutConstraint.activate([
    gifImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 0),
    gifImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 0),
    gifImageView.widthAnchor.constraint(equalToConstant: 50),
    gifImageView.heightAnchor.constraint(equalToConstant: 50)
    ])

    NSLayoutConstraint.activate([
      userDetailsView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 20),
      userDetailsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
      userDetailsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
      userDetailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
    ])


  }

  func configureBackgroundColor() {
    view.backgroundColor = .systemBackground
    scrollView.backgroundColor = .systemBackground

  }
  private func addSubviews() {
    view.addSubview(scrollView)
    scrollView.addSubview(profileImageView)
    scrollView.addSubview(favouriteButton)
    scrollView.addSubview(nameLabel)
    scrollView.addSubview(followersLabel)
    scrollView.addSubview(followingLabel)
    scrollView.addSubview(bioLabel)
    view.addSubview(gifImageView)
    scrollView.addSubview(userDetailsView)
    userDetailsView.translatesAutoresizingMaskIntoConstraints = false

  }



}
