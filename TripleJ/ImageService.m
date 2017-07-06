//
//  ImageService.m
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import "ImageService.h"

@interface ImageService ()

@property NSURLSession *defaultSession;
@property NSURLSessionDataTask *dataTask;

@end

@implementation ImageService

- (id) init {
  if (self = [super init]) {
    _defaultSession = [NSURLSession sessionWithConfiguration:
                       [NSURLSessionConfiguration defaultSessionConfiguration]];
  }
  return self;
}

- (void) retrieveImageForUrl: (NSString *) url withHandler: (void (UIImage *)) handler {
  if (_dataTask != NULL)
  	[_dataTask cancel];

  _dataTask = [_defaultSession dataTaskWithURL: [NSURL URLWithString: url] completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
    handler([[UIImage alloc] initWithData: data]);
  }];
  [_dataTask resume];
}

@end
