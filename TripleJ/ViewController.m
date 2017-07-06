//
//  ViewController.m
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import "ViewController.h"
#import "HeaderCell.h"
#import "PlayoutItemCell.h"
#import "PlayingCell.h"

#import "OnAir.h"

#import "OnAirService.h"
#import "ImageService.h"

@interface ViewController ()

@property OnAir *onAir;
@property OnAirService *service;
@property ImageService *imageService;

@property HeaderCell *headerCell;

- (void) retrieveData;

@end

@implementation ViewController

- (id) initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder: aDecoder]) {
    _service = [[OnAirService alloc] init];
    _imageService = [[ImageService alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self retrieveData];

  [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:true block:^(NSTimer *timer) {
    [[NSOperationQueue mainQueue] addOperationWithBlock: ^(void){ [_headerCell updateProgress]; }];
  }];

  [NSTimer scheduledTimerWithTimeInterval:10.0 repeats:true block:^(NSTimer *timer) {
    [self retrieveData];
  }];
}

- (void)retrieveData {
  [_service onAirFrom:@"http://aim.appdata.abc.net.au.edgesuite.net/data/abc/triplej/onair.xml" withHandler: ^(OnAir *newOnAir) {

    if (_onAir == NULL ||
        _onAir.egpItem.idNumber != newOnAir.egpItem.idNumber ||
        !([_onAir.playingItem isEqual: newOnAir.playingItem])) {

      _onAir = newOnAir;
      [[NSOperationQueue mainQueue] addOperationWithBlock: ^(void){ [_tableView reloadData]; }];
      [_imageService retrieveImageForUrl: newOnAir.egpItem.customFields[@"image640"] withHandler: ^(UIImage *image) {
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^(void){ [_background setImage: image]; }];
      }];
    }


  }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (_onAir == NULL)
  	return 0;

  return _onAir.playoutItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PlayoutItem *item = _onAir.playoutItems[indexPath.row];
  PlayoutItemCell *cell;

//  if (item.status == PLAYING) {
//    cell = (PlayingCell *) [_tableView dequeueReusableCellWithIdentifier: @"playing"];
//  } else {
    cell = (PlayoutItemCell *) [_tableView dequeueReusableCellWithIdentifier: @"playout"];
  //}

  [cell populateWithItem: item];

  return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  if (_onAir == NULL)
    return NULL;

  if (_headerCell == NULL)
    _headerCell = [_tableView dequeueReusableCellWithIdentifier: @"header"];

  [_headerCell populateWithItem: _onAir.egpItem];
  return _headerCell.contentView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (_onAir == NULL)
    return 0.0f;

  return 90.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80.0f;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat offset = _tableView.contentOffset.y;
  if (offset > 0.0f)
    return;

  _backgroundTop.constant = -20 - offset / 5.0;
}

@end
