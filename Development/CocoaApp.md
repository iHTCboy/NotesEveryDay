####  macOS 分享功能

Share:
```
    let picker = NSSharingServicePicker(items: [img])
    picker.delegate = self
    picker.show(relativeTo: .zero, of: sender as! NSView, preferredEdge: .maxX)
```

AirDrop:
```
    let service = NSSharingService(named: .sendViaAirDrop)!
    let items: [NSImage] = [img]
    if service.canPerform(withItems: items) {
        service.delegate = self
        service.perform(withItems: items)
    } else {
        print("Cannot perform AirDrop!")
    }
```

- [Creating a Custom macOS Sharing Service in Swift - Tristen Miller - Medium](https://medium.com/@hawkfalcon/creating-a-custom-macos-sharing-service-in-swift-e7e0e46cbdd3)
- [macOS Development - NSSharingService & NSSharingServicePicker - 简书](https://www.jianshu.com/p/c9fd1811b96f)
- [JustinFincher/WebDrop: 💻 Share your Mac's current chrome tab via airdrop](https://github.com/JustinFincher/WebDrop)
- [airshare with swift | FaiChou's Blog](https://faichou.space/air-share-with-swift/)