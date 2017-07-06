//
//  EGPItem.m
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import "EGPItem.h"
#import "OnAirService.h"

@implementation EGPItem

- (id)initWithDict:(NSDictionary *)dict {
  if (self = [super init]) {
    _idNumber = [(NSString *) dict[@"id"] integerValue];
    _name = (NSString *) dict[@"name"];
    _information = (NSString *) dict[@"description"];
    _time = [[OnAirService dateFormatter] dateFromString:(NSString *) dict[@"time"]];
    _duration = (NSString *) dict[@"duration"];
    _presenter = (NSString *) dict[@"presenter"];

    _customFields = [[NSMutableDictionary alloc] init];
  }
  return self;
}

- (double)durationValue {
  NSArray<NSString *> *cs = [_duration componentsSeparatedByString:@":"];
  NSInteger values[3];

  for (int i = 0; i < 3; i++)
    values[i] = [cs[i] integerValue];

  return values[0] * 3600 + values[1] * 60 + values[2];
}

- (double)progress {
  NSTimeInterval progress = [[[NSDate alloc] init] timeIntervalSinceDate: _time];
  double ratio = (double) progress / [self durationValue];

  return MIN(ratio, 1.0);
}

@end
