//
//  DefaultMarginDisabler.h
//  DefaultMarginDisabler
//
//  Created by abc on 8/21/16.
//  Copyright © 2016 Manabu Nakazawa. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface DefaultMarginDisabler : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end