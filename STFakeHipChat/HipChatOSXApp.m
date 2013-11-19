//  Copyright (c) 2013 Scott Talbot. All rights reserved.

#import "HipChatOSXApp.h"


static HipChatOSXApp *gHipChatOSXApp = nil;


@implementation HipChatOSXApp

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gHipChatOSXApp = [[self alloc] init];
    });
    return gHipChatOSXApp;
}

- (void)updatePresenceWithStatus:(NSString *)status {
    NSLog(@"%@(%p) updatePresenceWithStatus:%@", NSStringFromClass(self.class), self, status);
}

@end
