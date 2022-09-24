---
title: Add and remove footer using NSBox
categories: ['angle', 'cocoa', 'appkit', 'macos']
---

If you use macOS,
you have probably realized many apps have the following UI component on their settings:

![Screenshots that shows the UI controller that many apps use to add or remove items from a list](/images/posts/add-remove-nsbox.png)

I had to add one of those to the settings view of [Angle](https://angle.dev),
and then I realized that it's not a pre-defined component that you can drag & drop and use. _Does that mean we have to implement a custom view for it?_ You are right!
And that's what I ended up doing.

It took me several iterations until I got it right.
Since I'm sure I'm not the first one coming across this need, I'll leave the code snippet here:

```language-swift
import Foundation
import AppKit

class AddRemoveFooter: NSBox {

    // MARK: - Attributes

    fileprivate var addButton: NSButton!
    fileprivate var removeButton: NSButton!

    // MARK: - Init

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Internal

    func setAddAction(_ action: Selector?, target: AnyObject?) {
        addButton.action = action
        addButton.target = target
    }

    func setRemoveAction(_ action: Selector?, target: AnyObject?) {
        removeButton.action = action
        removeButton.target = target
    }

    // MARK: - Fileprivate

    fileprivate func setup() {
        setupStyle()
        setupButtons()
    }

    fileprivate func setupButtons() {
        contentView = NSView()
        contentView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView!.topAnchor.constraint(equalTo: self.topAnchor),
            contentView!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView!.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])

        addButton = NSButton(title: "+", target: nil, action: nil)
        addButton.bezelStyle = .shadowlessSquare
        addButton.translatesAutoresizingMaskIntoConstraints = false

        removeButton = NSButton(title: "﹣", target: nil, action: nil)
        removeButton.bezelStyle = .shadowlessSquare
        removeButton.translatesAutoresizingMaskIntoConstraints = false

        contentView!.addSubview(addButton)
        contentView!.addSubview(removeButton)

        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: contentView!.leadingAnchor, constant: 0),
            addButton.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 0),
            addButton.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: 0),
            addButton.widthAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            removeButton.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: -1),
            removeButton.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 0),
            removeButton.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: 0),
            removeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    fileprivate func setupStyle() {
        self.boxType = .custom
        self.alphaValue = 1
        self.borderColor = NSColor.gridColor
        self.borderType = .lineBorder
        self.borderWidth = 1
    }

}
```
