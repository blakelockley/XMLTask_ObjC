//
//  PlayoutItemCell.m
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import "PlayoutItemCell.h"
#import "ImageService.h"

@interface PlayoutItemCell ()

@property PlayoutItem *item;
@property ImageService *imageService;

@end

@implementation PlayoutItemCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if ( self = [super initWithCoder: aDecoder]) {
    _imageService = [[ImageService alloc] init];
  }
  return self;
}

- (void)populateWithItem: (PlayoutItem *) item {
  _item = item;
  _trackName.text = item.title;
  _artistName.text = item.artist;

  if (_timeLabel != NULL)
    _timeLabel.text = [item prettyTime];

  [_albumArt setHidden: YES];
  [_activityIndicator startAnimating];

  [_imageService retrieveImageForUrl: item.imageUrl withHandler: ^(UIImage *image){
    [[NSOperationQueue mainQueue] addOperationWithBlock: ^(void){
      [_albumArt setHidden: NO];
      [_albumArt setImage: image];
      [_activityIndicator stopAnimating];
    }];
  }];
}


@end
