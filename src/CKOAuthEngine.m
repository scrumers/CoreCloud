//
//  CKOAuthEngine.m
//  CloudKit
//
//  Created by Ludovic Galabru on 07/04/10.
//  Copyright 2010 Scrumers. All rights reserved.
//

#import "CKOAuthEngine.h"
#import "OAuthConsumer/OAuthConsumer.h"
#import "FBConnect/FBConnect.h"

@implementation CKOAuthEngine

@synthesize 
token = _token;

@synthesize 
consumer = _consumer;

@synthesize 
signatureProvider = _signatureProvider;

- (void)setupWithDictionary:(NSDictionary *)dictionary {
	
}

- (NSMutableURLRequest *)signRequest:(NSMutableURLRequest *)request {
	
}

- (void) dealloc {
	[_token release];
	[_consumer release];
	[_signatureProvider release];
	[super dealloc];
}


@end
