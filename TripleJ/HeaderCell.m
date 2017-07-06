//
//  HeaderCell.m
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import "HeaderCell.h"

@interface HeaderCell ()

@property EGPItem *item;

@end

@implementation HeaderCell


- (void) populateWithItem: (EGPItem *) item {
  _item = item;
  _name.text = item.name;
  _information.text = item.information;
  _time.text = item.customFields[@"displayTime"];

  [self updateProgress];
}

- (void)updateProgress {
  CGFloat progress = (CGFloat) [_item progress];
  CGFloat full = _fullBar.frame.size.width - 2.0f;

  _progressTrailing.constant = full * (1 - progress) + 1;
}



@end
