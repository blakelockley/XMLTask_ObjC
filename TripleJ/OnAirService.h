//
//  OnAirService.h
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OnAir.h"

@interface OnAirService : NSObject <NSXMLParserDelegate>

@property BOOL parsing;

- (void) onAirFrom: (NSString *) url withHandler: (void (^__strong) (OnAir *onAir)) handler;

@end
