//
//  CKCloudKitManager.m
//  Scrumers
//
//  Created by Ludovic Galabru on 25/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import "CKCloudKitManager.h"
#import "CKRequestManager.h"
#import "CKRequestOperation.h"
#import "CKEngine.h"

@implementation CKCloudKitManager

@synthesize ordered_engines;

- (id)init {
	self = [super init];
	if (self != nil) {
		ordered_engines= [[NSMutableArray alloc] init];
		engines= [[NSMutableDictionary alloc] init]; 
		droppedEngines= [[NSMutableDictionary alloc] init];
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

- (void)addEngine:(NSObject<CKEngine> *)engine withKey:(NSString *)key {
	[ordered_engines addObject:key];
	[engines setObject:engine forKey:key];
}

- (void)dropEngineWithKey:(NSString *)key {
	int index= [ordered_engines indexOfObject:key];
	[ordered_engines removeObject:key];
	[droppedEngines setValue:[NSNumber numberWithInt:index] forKey:key];
}

- (void)restaureDroppedEngines {
	for (id key in [droppedEngines allKeys]) {
		[ordered_engines insertObject:key atIndex:[[droppedEngines valueForKey:key] intValue]];
	}
}

- (NSObject<CKEngine> *)engineForKey:(NSString *)key {
	return [engines objectForKey:key];
}

- (void)sendRequest:(NSMutableURLRequest *)request withParams:(NSDictionary *)params andDelegate:(id)delegate {
	CKRequestOperation *requestOperation;
	requestOperation= [CKRequestOperation operationWithRequest:request
																											params:params
																										delegate:delegate 
																						andConfiguration:self];
	[[CKRequestManager sharedManager] processRequestOperation:requestOperation];
}

- (void)sendRequest:(NSMutableURLRequest *)request withParams:(NSDictionary *)params {
	[self sendRequest:request withParams:params andDelegate:nil];
}

- (void)sendRequest:(NSMutableURLRequest *)request withDelegate:(id)delegate {
	[self sendRequest:request withParams:nil andDelegate:delegate];
}

- (void)sendRequest:(NSMutableURLRequest *)request {
	[self sendRequest:request withParams:nil andDelegate:nil];
}


- (void)dealloc {
	[engines release];
	[ordered_engines release];
	[droppedEngines release];
	[super dealloc];
}

@end
