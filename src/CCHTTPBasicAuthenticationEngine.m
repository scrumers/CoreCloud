//
//  SHTTPBasicAuthenticationEngine.m
//  Sprints
//
//  Created by Ludovic Galabru on 07/04/10.
//  Copyright 2010 Scrumers. All rights reserved.
//

#import "CCHTTPBasicAuthenticationEngine.h"

#import "NSData+CoreCloudAdditions.h"

@interface CCHTTPBasicAuthenticationEngine (Private)

@end

@implementation CCHTTPBasicAuthenticationEngine

@synthesize
username= _username,
password= _password,
basic_authorization= _basic_authorization;

- (id)init {
	self = [super init];
	if (self != nil) {
	}
	return self;
}

- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSMutableDictionary **)params {
	if (self.basic_authorization == nil) {
		NSData *encodedCredentials;
		encodedCredentials= [[NSString stringWithFormat:@"%@:%@", self.username, self.password] dataUsingEncoding:NSASCIIStringEncoding];
		self.basic_authorization= [NSString stringWithFormat:@"Basic %@", [NSData base64stringforData:encodedCredentials]];		
	}
	[*request addValue:self.basic_authorization forHTTPHeaderField:@"Authorization"];
}


- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params data:(id *)data andError:(NSError **)error {
}

- (void) dealloc {
	[_username release];
	[_password release];
	[_basic_authorization release];
	[super dealloc];
}



@end
