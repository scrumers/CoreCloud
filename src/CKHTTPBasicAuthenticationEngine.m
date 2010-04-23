//
//  SHTTPBasicAuthenticationEngine.m
//  Sprints
//
//  Created by Ludovic Galabru on 07/04/10.
//  Copyright 2010 Scrumers. All rights reserved.
//

#import "CKHTTPBasicAuthenticationEngine.h"

#import "NSData+CloudKitAdditions.h"

@interface CKHTTPBasicAuthenticationEngine (Private)

@end

@implementation CKHTTPBasicAuthenticationEngine

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

- (void)setupWithDictionary:(NSDictionary *)dictionary {
	self.username= [dictionary valueForKey:@"username"];
	self.password= [dictionary valueForKey:@"password"];
	NSLog(@"Credentials= %@:%@", self.username, self.password);

	NSData *encodedCredentials;
	encodedCredentials= [[NSString stringWithFormat:@"%@:%@", self.username, self.password] dataUsingEncoding:NSASCIIStringEncoding];
	self.basic_authorization= [NSString stringWithFormat:@"Basic %@", [NSData base64forData:encodedCredentials]];
	NSLog(@"Encoded credentials= %@", self.basic_authorization);

}

- (NSMutableURLRequest *)signRequest:(NSMutableURLRequest *)request {
	[request addValue:self.basic_authorization forHTTPHeaderField:@"Authorization"];
	return request;
}

- (void) dealloc {
	[_username release];
	[_password release];
	[_basic_authorization release];
	[super dealloc];
}



@end
