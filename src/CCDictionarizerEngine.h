//
//  CCDictionarizerEngine.h
//  CoreCloud
//
//  Created by Ludovic Galabru on 5/20/10.
//  Copyright 2010 scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCEngine.h"

@interface CCDictionarizerEngine : NSObject <CCEngine> {
	NSString *_localPrefix;
}

- (id)initWithLocalPrefix:(NSString *)localPrefix;

- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSMutableDictionary **)params;
- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params data:(id *)data andError:(NSError **)error;

@property(nonatomic, retain)	NSString *localPrefix;

@end
