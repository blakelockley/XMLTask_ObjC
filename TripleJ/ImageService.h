//
//  ImageService.h
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageService : NSObject

- (void) retrieveImageForUrl: (NSString *) url withHandler: (void (UIImage *)) handler;

@end
