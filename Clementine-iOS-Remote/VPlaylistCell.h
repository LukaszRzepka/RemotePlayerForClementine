//
//  VPlaylistCell.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 09.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPlaylistCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelAlbum;
@property (weak, nonatomic) IBOutlet UILabel *labelArtist;
@property (weak, nonatomic) IBOutlet UILabel *labelPosition;
@property (weak, nonatomic) IBOutlet UILabel *labelLenght;
@end
