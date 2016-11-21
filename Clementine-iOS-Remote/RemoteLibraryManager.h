//
//  RemoteLibraryChunk.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 07.08.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClementineRemoteProtocolBuffer.pb.h"


@interface RemoteLibraryManager : NSObject
+ (instancetype)alloc __attribute__((unavailable("alloc not available, call sharedInstance")));
- (instancetype)init __attribute__((unavailable("init not available, call sharedInstance")));
+ (instancetype)new __attribute__((unavailable("new not available, call sharedInstance")));

+ (instancetype)sharedInstance;
@end
