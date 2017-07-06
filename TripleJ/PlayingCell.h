//
//  PlayingCell.h
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayoutItemCell.h"

@interface PlayingCell : PlayoutItemCell

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end
