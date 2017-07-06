//
//  OnAirService.m
//  TripleJ
//
//  Created by Blake Lockley on 6/7/17.
//  Copyright © 2017 Blake Lockley. All rights reserved.
//

#import "OnAirService.h"

@interface OnAirService ()

@property NSURLSession *defaultSession;
@property NSXMLParser *parser;
@property void (^handler)(OnAir *onAir);
@property EGPItem *egpItem;
@property PlayoutItem *currentPlayOutItem;
@property NSMutableArray<PlayoutItem *> *playoutItems;
@property BOOL parsingEGPFields;

- (void) finishWithError: (BOOL) error;

@end

@implementation OnAirService

- (id) init {
  if (self = [super init]) {
    _defaultSession = [NSURLSession sessionWithConfiguration:
                       [NSURLSessionConfiguration defaultSessionConfiguration]];
  }
  return self;
}

- (void)onAirFrom:(NSString *)url withHandler:(void (^__strong) (OnAir *))handler {
  if (_parsing)
    handler(NULL);

  _handler = handler;

  [[_defaultSession dataTaskWithURL: [NSURL URLWithString: url] completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
    _parser = [[NSXMLParser alloc] initWithData: data];
    _parser.delegate = self;
    [_parser parse];
  }] resume];
}

- (void)finishWithError:(BOOL)error {
  if (error)
    _handler(NULL);
  else
    _handler([[OnAir alloc] initWithEGPItem:_egpItem andPlayoutItems:_playoutItems]);

  if (_parsing) {
    [_parser abortParsing];
    _parsing = NO;
  }

  _handler = NULL;
  _egpItem = NULL;
  _currentPlayOutItem = NULL;
  _playoutItems = NULL;
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
  _parsing = YES;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
  _parsing = NO;
  [self finishWithError: NO];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {

  if ([elementName isEqualToString: @"egpItem"]) {
    _egpItem = [[EGPItem alloc] initWithDict: attributeDict];
    _parsingEGPFields = YES;
  } else if ([elementName isEqualToString: @"playoutData"]) {
    _playoutItems = [[NSMutableArray alloc] init];
  } else if ([elementName isEqualToString: @"playoutItem"]) {
    _currentPlayOutItem = [[PlayoutItem alloc] initWithDict: attributeDict];
  } else if ([elementName isEqualToString: @"customField"]) {
    NSString *name = attributeDict[@"name"];
    NSString *value = attributeDict[@"value"];
    if (_parsingEGPFields) {
      _egpItem.customFields[name] = value;
    } else {
      _currentPlayOutItem.customFields[name] = value;
    }
  }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

  if ([elementName isEqualToString: @"egpItem"]) {
    _parsingEGPFields = NO;
  } else if ([elementName isEqualToString: @"playoutItem"]) {
    [_playoutItems addObject: _currentPlayOutItem];
  }
}

@end
