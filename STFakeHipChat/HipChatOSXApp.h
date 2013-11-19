//  Copyright (c) 2013 Scott Talbot. All rights reserved.

#import <Foundation/Foundation.h>


@interface HipChatOSXApp : NSObject
+ (instancetype)instance;
- (void)updatePresenceWithStatus:(NSString *)status;
@end
