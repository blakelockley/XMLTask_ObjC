//
//  HeaderCell.h
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGPItem.h"

@interface HeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *information;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIView *fullBar;
@property (weak, nonatomic) IBOutlet UIView *progressBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressTrailing;

- (void) populateWithItem: (EGPItem *) item;
- (void) updateProgress;

@end
