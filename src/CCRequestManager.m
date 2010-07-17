//
//  CCRequestManager.m
//  Scrumers
//
//  Created by Ludovic Galabru on 27/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import "CCRequestManager.h"
#import "CCRequestOperation.h"

@implementation CCRequestManager

- (id)init {
	self = [super init];
	if (self != nil) {
		operationQueue = [[NSOperationQueue alloc] init];
		[operationQueue setMaxConcurrentOperationCount:1];
	}
	return self;
}

+ (id)sharedManager {
	static CCRequestManager * defaultManager = nil;
	if (defaultManager == nil) {
		defaultManager = [[CCRequestManager alloc] init];
	}
	return defaultManager;
}

- (void)processRequestOperation:(CCRequestOperation *)operation {
	[operationQueue addOperation:operation];
}

- (void)cancelAllRequestOperations {
	[operationQueue cancelAllOperations];
}

- (void)dealloc {
	[operationQueue cancelAllOperations];
	[operationQueue release];
	[super dealloc];
}


@end
