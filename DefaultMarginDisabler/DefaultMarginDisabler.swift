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
  private static var setupOnceToken: dispatch_once_t = 0
  private static var sharedPlugin: DefaultMarginDisabler?
  private var bundle: NSBundle

  init(bundle: NSBundle) {
    self.bundle = bundle
    super.init()

    NSNotificationCenter.defaultCenter().addObserver(self, selector: "xcodeDidFinishLaunching:", name: NSApplicationDidFinishLaunchingNotification, object: nil)
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }

  class func pluginDidLoad(bundle: NSBundle) {
    let appName = NSBundle.mainBundle().infoDictionary?["CFBundleName"] as? NSString

    if appName == "Xcode" {
      dispatch_once(&setupOnceToken) {
        self.sharedPlugin = DefaultMarginDisabler(bundle: bundle)
      }
    }
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

        guard btn.enabled else {
          return
        }

        btn.state = NSOffState
        NSTimer.scheduledTimerWithTimeInterval(0, target: t, selector: btn.action, userInfo: nil, repeats: false)
      }
    }
  }
}
