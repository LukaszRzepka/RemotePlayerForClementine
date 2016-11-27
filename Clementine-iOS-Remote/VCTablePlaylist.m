//
//  VCTablePlaylist.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 09.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "VCTablePlaylist.h"
#import "VPlaylistCell.h"
#import "RemotePlaylistManager.h"
#import "Constants.h"
#import "RemotePlayer.h"

@interface VCTablePlaylist ()
@property (nonatomic, strong)RemotePlaylist *playlist;
@end

@implementation VCTablePlaylist

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateDataSource];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentPlaylistSongsDidChangeNotification:) name:ClementinePlayerCurrentPlaylistSongsDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentPlaylistDidChangeNotification:) name:ClementinePlayerCurrentPlaylistDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentSongDidChangeNotification:) name:ClementinePlayerCurrentSongDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playlist.songsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VPlaylistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaylistCell"];
    
    RemoteSong *song = [self.playlist.songs objectAtIndex:indexPath.row];
    
    [cell.labelTitle setText:song.title];
    [cell.labelAlbum setText:song.album];
    [cell.labelArtist setText:song.artist];
    [cell.labelPosition setText:[NSString stringWithFormat:@"%ld.", indexPath.row  + 1]];
    
    NSUInteger seconds = song.lenght % 60;
    if (seconds < 10) {
        [cell.labelLenght setText:[NSString stringWithFormat:@"%ld:0%ld", song.lenght / 60, seconds]];
    } else {
        [cell.labelLenght setText:[NSString stringWithFormat:@"%ld:%ld", song.lenght / 60, seconds]];
    }

    if (song.songId == [RemotePlayer sharedInstance].currentSong.songId) {
        [cell setAllLabelsTextColorTo:[UIColor orangeColor]];
    } else {
        [cell setAllLabelsTextColorTo:[UIColor whiteColor]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RemoteSong *song = [self.playlist.songs objectAtIndex:indexPath.row];
    [[RemotePlaylistManager sharedInstance].playlistSenderService setCurrentSong:song.index playlistId:self.playlist.playlistId];
}

- (void)currentPlaylistDidChangeNotification:(NSNotification*)note {
   dispatch_async(dispatch_get_main_queue(), ^{});
}

- (void)currentPlaylistSongsDidChangeNotification:(NSNotification*)note {
    __weak __typeof__(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __typeof__(self)strongSelf = weakSelf;
        [strongSelf updateDataSource];
        [strongSelf.tableView reloadData];
    });
}

- (void)currentSongDidChangeNotification:(NSNotification*)note {
    __weak __typeof__(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __typeof__(self)strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    });
}

- (void)updateDataSource {
    self.playlist = [RemotePlaylistManager sharedInstance].currentPlaylist;
}


@end
