//
//  OnAir.h
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayoutItem.h"
#import "EGPItem.h"

@interface OnAir : NSObject

@property EGPItem *egpItem;
@property NSArray<PlayoutItem *> *playoutItems;

- (PlayoutItem *) playingItem;
- (id) initWithEGPItem: (EGPItem *) egpItem andPlayoutItems: (NSArray<PlayoutItem *> *) playoutItems;

@end
