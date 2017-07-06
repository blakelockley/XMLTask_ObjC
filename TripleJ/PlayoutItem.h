//
//  PlayoutItem.h
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  PLAYING,
  HISTORY
} PlayoutItemStatus;

typedef enum {
  SONG
} PlayoutItemType;

@interface PlayoutItem : NSObject

@property NSDate *time;
@property NSString *duration, *title, *artist, *imageUrl;
@property PlayoutItemStatus status;
@property PlayoutItemType type;
@property NSDictionary *customFields;

- (id) initWithDict: (NSDictionary *) dict;
- (NSString *) prettyTime;
- (NSString *) prettyDuration;

@end
