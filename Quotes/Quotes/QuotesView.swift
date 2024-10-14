//
//  QuotesView.swift
//  QuotesApp
//
//  Created by Doni Silva on 24/08/24.
//

import UIKit

final public class QuotesView: UIView {
    
    private enum Constants {
        static let alphaPhotoBg: CGFloat = 0.10
        static let fontType = "Savoye LET"
        static let fontQuoteSize: CGFloat = 40
        static let fontAutorSize: CGFloat = 42
        static let photoHeight: CGFloat = 360
        static let topConstraint: CGFloat = 40
        static let animationDuration: CGFloat = 2.5
        static let alphaComplete: CGFloat = 1.0
    }
    
    // MARK: - UI
    
    public lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var blurredEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurredEffectView
    }()
    
    private lazy var photoBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = Constants.alphaPhotoBg
        return imageView
    }()
    
    private lazy var ivPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    public lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: Constants.fontType, size: Constants.fontQuoteSize)
        label.numberOfLines = .zero
        label.adjustsFontSizeToFitWidth = true
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }()
    
    public lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: Constants.fontType, size: Constants.fontAutorSize)
        label.textColor = .appPrimary
        return label
    }()
    
    private var quoteTopConstraint: NSLayoutConstraint?
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(blurredEffectView)
        view.addSubview(photoBackground)
        view.addSubview(ivPhoto)
        view.addSubview(quoteLabel)
        view.addSubview(authorLabel)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        blurredEffectView.constraintToSuperView()
        photoBackground.constraintToSuperView()
        
        ivPhoto.topTo(view.safeAreaLayoutGuide.topAnchor, constant: SizeMetrics.little)
        ivPhoto.leadingTo(view.leadingAnchor)
        ivPhoto.trailingTo(view.trailingAnchor)
        ivPhoto.height(Constants.photoHeight)

        quoteLabel.leadingTo(view.leadingAnchor, constant: SizeMetrics.large)
        quoteLabel.trailingTo(view.trailingAnchor, constant: SizeMetrics.large)
        
        quoteTopConstraint = quoteLabel.topAnchor.constraint(
            equalTo: ivPhoto.bottomAnchor, constant: Constants.topConstraint)
        quoteTopConstraint?.isActive = true
        
        authorLabel.topTo(quoteLabel.bottomAnchor, constant: SizeMetrics.small)
        authorLabel.centerXTo(view.centerXAnchor)
        authorLabel.bottomToLess(view.safeAreaLayoutGuide.bottomAnchor, constant: SizeMetrics.medium)
    }
    
    public func animate(quote: QuoteEntity) {
        let quote = quote
        quoteLabel.text = "\(quote.formattedQuote)"
        authorLabel.text = "\(quote.formattedAuthor)"
        ivPhoto.image = UIImage(named: quote.image)
        photoBackground.image = ivPhoto.image
        
        quoteLabel.alpha = .zero
        authorLabel.alpha = .zero
        ivPhoto.alpha = .zero
        photoBackground.alpha = .zero
        quoteTopConstraint?.constant = Constants.topConstraint
        layoutIfNeeded()
        
        UIView.animate(withDuration: Constants.animationDuration) {
            self.quoteLabel.alpha = Constants.alphaComplete
            self.authorLabel.alpha = Constants.alphaComplete
            self.ivPhoto.alpha = Constants.alphaComplete
            self.photoBackground.alpha = Constants.alphaPhotoBg
            self.quoteTopConstraint?.constant = SizeMetrics.medium
            self.layoutIfNeeded()
        }
    }
}
