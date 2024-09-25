//
//  GitHubFollowerCell.swift
//  GithubDummy
//
//  Created by MacBook AIR on 25/09/2024.
//

import Foundation
import UIKit
import SDWebImage
class GitHubFollowerCell: UITableViewCell {

    static let identifier = "GitHubFollowerCell"


     private let profileImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.layer.masksToBounds = true
         imageView.image = UIImage(named: "6")
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFill
           imageView.backgroundColor = .green
         imageView.layer.cornerRadius = 16
         return imageView
     }()

    private let profileNameLabel: UILabel = {
         let label = UILabel()
         label.textColor = .label
         label.numberOfLines = 0
         label.font = .systemFont(ofSize: 16)
         label.textAlignment = .left
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "0"
         return label
    }()


  private let idLabel: UILabel = {
       let label = UILabel()
       label.textColor = .systemGray
       label.numberOfLines = 0
       label.font = .systemFont(ofSize: 10)
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       label.text = "0"
       return label
  }()



     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         addSubviews()
         configureLayout()
         contentView.layer.cornerRadius = 4
     }
    private func addSubviews() {
      contentView.addSubview( profileImageView)
      contentView.addSubview( profileNameLabel)
      contentView.addSubview( idLabel)
    }

   private  func configureLayout() {
         NSLayoutConstraint.activate([
             profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
             profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
             profileImageView.widthAnchor.constraint(equalToConstant: 32),
             profileImageView.heightAnchor.constraint(equalToConstant: 32),

             profileNameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
             profileNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
             profileNameLabel.heightAnchor.constraint(equalToConstant: 20),
             profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),


             idLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor),
             idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
             idLabel.heightAnchor.constraint(equalToConstant: 20),
             idLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)




         ])

     }

    func configure( _ viewModel:Repository) {
      guard let url = URL(string: viewModel.owner?.avatarUrl ?? "") else {
        profileImageView.image = UIImage(systemName: "person.fill")
        return
      }
      profileImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.fill")) { image, error, cacheType, imageURL in
           if let error = error {
               print("Error loading image: \(error.localizedDescription)")
               self.profileImageView.image = UIImage(systemName: "person.fill")
           }
       }

      profileNameLabel.text = viewModel.name
      idLabel.text = String(viewModel.id)
    }
}
