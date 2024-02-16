//
//  FlickerImageViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 14.02.2024.
//

import ViperMcFlurry
import Kingfisher
import SnapKit

final class FlickerImageViewController: UIViewController {
  
  // MARK: - Connections
  
  var output: FlickerImageViewOutputProtocol?
  
  // MARK: - UI Properties
  
  private let flickerImageView = UIImageView()
  private let scrollView = UIScrollView()
  
  // MARK: - View did load
  
  override func viewDidLoad() {
    super.viewDidLoad()
    embedViews()
    setupLayout()
    setupAppereance()
    setupBehavior()
    
    output?.viewDidLoad()
  }
}

// MARK: - Setup view content

private extension FlickerImageViewController {
  
  // MARK: - Embed views
  
  func embedViews() {
    scrollView.addSubview(flickerImageView)
    let subviews = [scrollView]
    subviews.forEach { subview in
      view.addSubview(subview)
    }
    
  }
  
  // MARK: - Setup layout
  
  func setupLayout() {
    
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(view.snp.top)
      make.right.equalTo(view.snp.right)
      make.left.equalTo(view.snp.left)
      make.bottom.equalTo(view.snp.bottom)
    }
    
    flickerImageView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.equalToSuperview()
      make.height.equalToSuperview()
    }
    
  }
  
  // MARK: - Setup appereance
  
  func setupAppereance() {
    view.backgroundColor = .darkGray
    
    flickerImageView.layer.cornerRadius  = 10
    flickerImageView.layer.masksToBounds = true
    flickerImageView.contentMode = .scaleAspectFill
  }
  
  // MARK: - Setup behavior
  
  func setupBehavior() {
    
    scrollView.delegate = self
    scrollView.maximumZoomScale = 4.0
    scrollView.minimumZoomScale = 1.0
    flickerImageView.isUserInteractionEnabled = true
    
  }
  
}

// MARK: - UIScrollViewDelegate

extension FlickerImageViewController: UIScrollViewDelegate {
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return flickerImageView
  }
  
  func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
    UIView.animate(withDuration: 0.2) {
      scrollView.setZoomScale(1.0, animated: true)
    }
  }
  
}

// MARK: - FlickerImageViewInputProtocol

extension FlickerImageViewController: FlickerImageViewInputProtocol {
  
  func viewDidLoadFromOutput(flickerImageURL: URL) {
    flickerImageView.kf.setImage(with: flickerImageURL, placeholder: UIImage(named: "Cosmos"))
  }
  
}
