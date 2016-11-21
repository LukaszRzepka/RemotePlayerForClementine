//
//  Song.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 27.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIkit.h"
#import "ClementineRemoteProtocolBuffer.pb.h"

@interface RemoteSong : NSObject
- (instancetype)initWithSongMetadata:(SongMetadata*)songMetadata;
@property (nonatomic)BOOL loved;
@property (nonatomic)BOOL local;
@property (nonatomic)long size;
@property (nonatomic)float rating;
@property (nonatomic)NSInteger songId;
@property (nonatomic)NSInteger track;
@property (nonatomic)NSInteger disc;
@property (nonatomic)NSInteger playCount;
@property (nonatomic)NSInteger lenght;
@property (nonatomic)NSInteger index;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *artist;
@property (nonatomic, strong)NSString *album;
@property (nonatomic, strong)NSString *albumArtist;
@property (nonatomic, strong)NSString *prettyLenght;
@property (nonatomic, strong)NSString *genre;
@property (nonatomic, strong)NSString *year;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *filename;
@property (nonatomic, strong)UIImage *art;
@end
