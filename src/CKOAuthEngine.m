//
//  CKOAuthEngine.m
//  CloudKit
//
//  Created by Ludovic Galabru on 07/04/10.
//  Copyright 2010 Scrumers. All rights reserved.
//

#import "CKOAuthEngine.h"
#import "OAuthConsumer/OAuthConsumer.h"

@implementation CKOAuthEngine

@synthesize 
token = _token;

@synthesize 
consumer = _consumer;

@synthesize 
signatureProvider = _signatureProvider;


- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSMutableDictionary **)params {
}

- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params data:(id *)data andError:(NSError **)error {
}


- (void) dealloc {
	[_token release];
	[_consumer release];
	[_signatureProvider release];
	[super dealloc];
}


@end
