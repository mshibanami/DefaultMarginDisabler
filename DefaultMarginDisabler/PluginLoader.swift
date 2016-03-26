//
//  PluginLoader.swift
//
//  Created by mshibanami on 2016/03/13.
//  Copyright © 2016年 mshibanami. All rights reserved.
//

import Foundation

extension NSObject {
  private static var setupOnceToken: dispatch_once_t = 0
  private static var sharedPlugin: DefaultMarginDisabler?

  class func pluginDidLoad(bundle: NSBundle) {
    let appName = NSBundle.mainBundle().infoDictionary?["CFBundleName"] as? NSString

    if appName == "Xcode" {
      dispatch_once(&setupOnceToken) {
        self.sharedPlugin = DefaultMarginDisabler(bundle: bundle)
      }
    }
  }
}