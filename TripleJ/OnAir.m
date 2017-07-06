//
//  OnAir.m
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import "OnAir.h"

@implementation OnAir

-(id)initWithEGPItem:(EGPItem *)egpItem andPlayoutItems:(NSArray<PlayoutItem *> *)playoutItems {
  if ( self = [super init] ) {
    _egpItem = egpItem;
    _playoutItems = playoutItems;
  }
  return self;
}

- (PlayoutItem *)playingItem {
  if (_playoutItems.count < 1)
    return NULL;

  PlayoutItem *first = [_playoutItems objectAtIndex: 0];

  if (first.status == PLAYING)
    return first;
  else
    return NULL;
}

@end
