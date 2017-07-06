//
//  ViewController.h
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundTop;

@end

