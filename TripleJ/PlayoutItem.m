//
//  PlayoutItem.m
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import "PlayoutItem.h"

@interface PlayoutItem ()

@property NSDateFormatter *dateFormatter;

@end

@implementation PlayoutItem

- (id)initWithDict:(NSDictionary *)dict {
  if ( self = [super init] ) {
    _time = [[NSDate alloc] init]; //TODO: use formatter in OnAirService
    _duration = (NSString *) dict[@"duration"];
    _title = (NSString *) dict[@"title"];
    _artist = (NSString *) dict[@"artist"];
    _imageUrl = (NSString *) dict[@"imageUrl"];

    NSString *status, *type;
    status = (NSString *) dict[@"status"];
    if ([status isEqualToString: @"PLAYING"])
      _status = PLAYING;
    else if ([status isEqualToString: @"HISTORY"])
      _status = HISTORY;
    else
      return nil;

    type = (NSString *) dict[@"type"];
    if ([status isEqualToString: @"SONG"])
      _type = SONG;
    else
      return nil;

    _dateFormatter = [[NSDateFormatter alloc ] init];
    _dateFormatter.dateFormat = @"h:mma";
  }
  return self;
}

- (NSString *)prettyTime {
  return [_dateFormatter stringFromDate: _time];
}

- (NSString *)prettyDuration {
  NSString *hours = [[_duration componentsSeparatedByString:@":"] objectAtIndex: 0];

  if (![hours isEqualToString: @"00"])
    return _duration;

  return [_duration substringFromIndex:3]; //skip @"00:"
}

@end
