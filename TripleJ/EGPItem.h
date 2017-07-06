//
//  EGPItem.h
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EGPItem : NSObject

@property NSInteger idNumber;
@property NSString *name, *information, *duration, *presenter;
@property NSDate *time;
@property NSMutableDictionary *customFields;

- (id) initWithDict: (NSDictionary *) dict;
- (double) durationValue;
- (double) progress;

@end
