//
//  ClementineConnectionDelegate.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 29.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol RemoteConnectionDelegate <NSObject>
- (void)clementineConnectionDidChage:(ClementineConnectionStatus)status;
- (void)clementineHaveDataToRead:(NSData*)data;
@end
