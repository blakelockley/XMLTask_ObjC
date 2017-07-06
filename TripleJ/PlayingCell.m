//
//  PlayingCell.m
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import "PlayingCell.h"

@implementation PlayingCell

- (void)populateWithItem: (PlayoutItem *) item {
  [super populateWithItem: item];
  _durationLabel.text = [item prettyDuration];
}

@end
