//
//  TextFieldContentConfiguration.swift
//  Challenge
//
//  Created by Michael Steudter on 12.07.22.
//	Based on https://stackoverflow.com/a/68621466/1898677

import UIKit

/// Configures a cell showing a textfield.
struct TextFieldContentConfiguration: UIContentConfiguration {
	/// The textfield's text.
	var text: String?
	/// The textfield's placeholder text.
	var placeholder: String?
	/// Called whenever the text was changed.
	var textChanged: ((String?) -> Void)?

	func makeContentView() -> UIView & UIContentView {
		return TextFieldContentView(configuration: self)
	}

	func updated(for state: UIConfigurationState) -> TextFieldContentConfiguration {
		return self
	}
}

/// `UIContentView` used in `TextFieldContentConfiguration` for showing a textfield in a cell.
final class TextFieldContentView: UIView, UIContentView, UITextFieldDelegate {
	public var configuration: UIContentConfiguration {
		get {
			return appliedConfiguration
		}
		set {
			if let config = newValue as? TextFieldContentConfiguration {
				apply(configuration: config)
			}
		}
	}

	private var appliedConfiguration: TextFieldContentConfiguration = TextFieldContentConfiguration()

	private func apply(configuration: TextFieldContentConfiguration) {
		textField.text = configuration.text
		textField.placeholder = configuration.placeholder
		self.appliedConfiguration = configuration
	}

	required init(configuration: TextFieldContentConfiguration) {
		textField = UITextField(frame: .zero)
		textField.translatesAutoresizingMaskIntoConstraints = false

		super.init(frame: .zero)

		addViews()
		apply(configuration: configuration)

		textFieldToken = NotificationCenter.default.addObserver(
			forName: UITextField.textDidChangeNotification,
			object: textField,
			queue: .main,
			using: { [weak self] notification in
				guard let textField = notification.object as? UITextField else {
					return
				}
				self?.appliedConfiguration.textChanged?(textField.text)
			})
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError()
	}

	private func addViews() {
		addSubview(textField)

		let guide = layoutMarginsGuide
		NSLayoutConstraint.activate([
			textField.topAnchor.constraint(equalTo: guide.topAnchor),
			textField.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
			textField.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
			textField.trailingAnchor.constraint(equalTo: guide.trailingAnchor)
		])
	}

	private let textField: UITextField
	private var textFieldToken: Any?
}
