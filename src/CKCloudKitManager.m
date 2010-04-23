//
//  CKCloudKitManager.m
//  Scrumers
//
//  Created by Ludovic Galabru on 25/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import "CKCloudKitManager.h"

@implementation CKCloudKitManager

@synthesize 
domain= _domain,
protocol= _protocol,
subdomain= _subdomain,
api_path= _api_path;

@synthesize
authenticationEngine= _authenticationEngine;

@synthesize
serializationEngine= _serializationEngine;

@synthesize
instanciationEngine= _instanciationEngine;

- (id)init {
	self = [super init];
	if (self != nil) {
		self.protocol= @"http://";
		self.subdomain= @"";
		self.domain= @"";
		self.api_path= @"";
	}
	return self;
}

+ (CKCloudKitManager *)defaultConfiguration {
	static CKCloudKitManager * defaultConfiguration = nil;
	if (defaultConfiguration == nil) {
		defaultConfiguration = [[CKCloudKitManager alloc] init];
	}
	return defaultConfiguration;
}

- (NSMutableURLRequest *)signRequest:(NSMutableURLRequest *)request {
	return [_authenticationEngine signRequest:request];
}

- (void)dealloc {
	[_domain release];
	[_api_path release];
	[_subdomain release];
	[_protocol release];
	[_authenticationEngine release];
	[_serializationEngine release];
	[_instanciationEngine release];
	[super dealloc];
}

@end
