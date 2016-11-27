//
//  VPlaylistCell.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 09.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "VPlaylistCell.h"

@implementation VPlaylistCell
- (void)setAllLabelsTextColorTo:(UIColor*)color {
    self.labelAlbum.textColor = color;
    self.labelTitle.textColor = color;
    self.labelArtist.textColor = color;
    self.labelLenght.textColor = color;
    self.labelPosition.textColor = color;
}
@end
