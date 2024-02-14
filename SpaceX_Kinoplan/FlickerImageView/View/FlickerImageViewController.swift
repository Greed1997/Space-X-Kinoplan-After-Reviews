//
//  FlickerImageViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 14.02.2024.
//

import ViperMcFlurry
import Kingfisher
import SnapKit

// MARK: - FlickerImageViewController

final class FlickerImageViewController: UIViewController {
  
  // MARK: - Connections
  
  var output: FlickerImageViewOutputProtocol?
  
  // MARK: - UI Properties
  
  let flickerImageView = UIImageView()
  
  // MARK: - Properties
  
  var flickerImageViewModel: FlickerImageViewModel!
  
  
  // MARK: - View did load
  
  override func viewDidLoad() {
    super.viewDidLoad()
    embedViews(subviews: flickerImageView)
    setupLayout()
    setupAppereance()
    setupBehavior()
    
    output?.viewDidLoad()
  }
}

// MARK: - Setup view content

private extension FlickerImageViewController {
  
  // MARK: - Embed views
  
  func embedViews(subviews: UIView...) {
    subviews.forEach { subview in
      subview.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(subview)
    }
  }
  
  // MARK: - Setup layout
  
  func setupLayout() {
    flickerImageView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
      make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
      make.bottom.equalTo(view.snp.bottom)
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
    let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(gesture:)))
    
    flickerImageView.isUserInteractionEnabled = true
    flickerImageView.addGestureRecognizer(pinchGestureRecognizer)
  }
  
}

// MARK: - Objc methods

private extension FlickerImageViewController {
  
  @objc
  func handlePinch(gesture: UIPinchGestureRecognizer) {
    if gesture.state == .began || gesture.state == .changed {
      
      guard let gestureView = gesture.view else { return }
      gestureView.transform = gestureView.transform.scaledBy(x: gesture.scale, y: gesture.scale)
      gesture.scale = 1.0
    }
    //    if let view = gesture.view {
    //      view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
    //      gesture.scale = 1.0
    //    }
  }
  
//  @objc
//  func handlePinch(sender: UIPinchGestureRecognizer) {
//    guard sender.view != nil else { return }
//    
//    if sender.state == .began || sender.state == .changed {
//      
//      let currentScale = sender.view!.frame.size.width / sender.view!.bounds.size.width
//      var newScale     = currentScale * sender.scale
//      
//      if newScale < 1 {
//        newScale = 1
//      } else if newScale > 4 {
//        newScale = 4
//      }
//      
//      let transform = CGAffineTransform(scaleX: newScale, y: newScale)
//      
//      sender.view?.transform = transform
//      sender.scale = 1
//    }
//  }
}

// MARK: - FlickerImageViewInputProtocol

extension FlickerImageViewController: FlickerImageViewInputProtocol {
  
  func viewDidLoadFromOutput(flickerImageViewModel: FlickerImageViewModel) {
    flickerImageView.kf.setImage(with: flickerImageViewModel.flickerImageURL)
  }
}
