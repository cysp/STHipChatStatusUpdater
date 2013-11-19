//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2013 Scott Talbot.

#import "STHipChatStatusUpdater.h"


NSString * const STHipChatStatusUpdateNotification = @"STHipChatStatusUpdate";
NSString * const STHipChatStatusUpdateStatusKey = @"status";


static STHipChatStatusUpdater *gSTHipChatStatusUpdater = nil;


@protocol HipChatOSXApp <NSObject>
+ (instancetype)instance;
- (void)updatePresenceWithStatus:(NSString *)status;
@end


@interface STHipChatStatusUpdater ()
@property (nonatomic,assign,getter=isListening) BOOL listening;
@end

@implementation STHipChatStatusUpdater {
@private
    NSDistributedNotificationCenter *_dnc;
}

+ (void)load {
    if (self == [STHipChatStatusUpdater class]) {
        NSLog(@"STHipChatStatusUpdater Injected");
        [[STHipChatStatusUpdater sharedInstance] setListening:YES];
    }
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gSTHipChatStatusUpdater = [[STHipChatStatusUpdater alloc] init];
    });
    return gSTHipChatStatusUpdater;
}

- (void)setListening:(BOOL)listening {
    if (listening != _listening) {
        _listening = listening;
        if (listening) {
            _dnc = [NSDistributedNotificationCenter notificationCenterForType:NSLocalNotificationCenterType];
            [_dnc addObserver:self selector:@selector(statusUpdateNotification:) name:STHipChatStatusUpdateNotification object:nil suspensionBehavior:NSNotificationSuspensionBehaviorCoalesce];
        } else {
            [_dnc removeObserver:self name:STHipChatStatusUpdateNotification object:nil];
        }
    }
}


- (void)statusUpdateNotification:(NSNotification *)note {
    NSString * const status = note.userInfo[STHipChatStatusUpdateStatusKey];
    Class<HipChatOSXApp> HipChatOSXAppClass = NSClassFromString(@"HipChatOSXApp");
    id hc = [HipChatOSXAppClass instance];
    [hc updatePresenceWithStatus:status];
}

@end
