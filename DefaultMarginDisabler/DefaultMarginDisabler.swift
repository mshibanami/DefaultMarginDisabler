//
//  DefaultMarginDisabler.swift
//  DefaultMarginDisabler
//
//  Created by mshibanami on 2015/11/19.
//  Copyright © 2015 mshibanami. All rights reserved.
//

import Foundation
import Cocoa

class DefaultMarginDisabler: NSObject {
  private var bundle: NSBundle

  init(bundle: NSBundle) {
    self.bundle = bundle
    super.init()

    NSNotificationCenter.defaultCenter().addObserver(self, selector: "xcodeDidFinishLaunching:", name: NSApplicationDidFinishLaunchingNotification, object: nil)
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }

  func xcodeDidFinishLaunching(notification: NSNotification) {
    let center = NSNotificationCenter.defaultCenter()

    center.removeObserver(self, name: NSApplicationDidFinishLaunchingNotification, object: nil)
    center.addObserver(self, selector: "popoverWillShowNotificationListener:", name: NSPopoverWillShowNotification, object: nil)
  }

  func popoverWillShowNotificationListener(notification: NSNotification) {

    if let popover = notification.object as? NSPopover,
       let views = popover.contentViewController?.view.subviews.first?.subviews {

      let buttons = views.filter {
        $0.isKindOfClass(NSButton) && ($0 as! NSButton).title == "Constrain to margins"
      } as! [NSButton]

      if let btn = buttons.first,
         let t = btn.target {

        guard btn.enabled && btn.state == NSOnState else {
          return
        }

        btn.state = NSOffState
        t.performSelector(btn.action)
      }
    }
  }
}
