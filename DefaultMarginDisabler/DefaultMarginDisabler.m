//
//  DefaultMarginDisabler.m
//  DefaultMarginDisabler
//
//  Created by abc on 8/21/16.
//  Copyright © 2016 Manabu Nakazawa. All rights reserved.
//

#import "DefaultMarginDisabler.h"

static DefaultMarginDisabler *sharedPlugin;

@implementation DefaultMarginDisabler

#pragma mark - Initialization

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    sharedPlugin = [[self alloc] initWithBundle:plugin];
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)bundle
{
    if (self = [super init])
    {
        _bundle = bundle;

        if (NSApp && !NSApp.mainMenu)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(applicationDidFinishLaunching:)
                                                         name:NSApplicationDidFinishLaunchingNotification
                                                       object:nil];
        }
        else
        {
            [self initializeAndLog];
        }
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    [self initializeAndLog];
}

- (void)initializeAndLog
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popoverWillShowNotificationListener:) name:NSPopoverWillShowNotification object:nil];
}

#pragma mark - Implementation

- (void)popoverWillShowNotificationListener:(NSNotification *)notification
{
    NSPopover *popover = notification.object;

    if (![popover isKindOfClass:NSPopover.class])
    {
        return;
    }

    NSArray<NSView *> *views = popover.contentViewController.view.subviews.firstObject.subviews;

    if (!views)
    {
        return;
    }

    NSButton *btn = (NSButton *)[views filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSView *evaluatedObject, NSDictionary<NSString *, id> *bindings)
    {
        return [evaluatedObject isKindOfClass:[NSButton class]]
            && [[(NSButton *)evaluatedObject title] isEqualToString:@"Constrain to margins"];
    }]].firstObject;

    if (!btn || !btn.enabled || btn.state != NSOnState)
    {
        return;
    }

    btn.state = NSOffState;

    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"

    [btn.target performSelector:btn.action];

    #pragma clang diagnostic pop
}

@end
