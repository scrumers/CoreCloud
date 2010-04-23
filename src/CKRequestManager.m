//
//  CKRequestManager.m
//  Scrumers
//
//  Created by Ludovic Galabru on 27/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import "CKRequestManager.h"
#import "CKRequestOperation.h"

@implementation CKRequestManager

- (id)init {
	self = [super init];
	if (self != nil) {
		operationQueue = [[NSOperationQueue alloc] init];
		[operationQueue setMaxConcurrentOperationCount:1];
	}
	return self;
}

+ (id)sharedManager {
	static CKRequestManager * defaultManager = nil;
	if (defaultManager == nil) {
		defaultManager = [[CKRequestManager alloc] init];
	}
	return defaultManager;
}

- (void)sendRequest:(NSMutableURLRequest *)request withDelegate:(id)delegate {
	CKRequestOperation *operation = [CKRequestOperation operationWithRequest:request andDelegate:delegate];
	[operationQueue addOperation:operation];
}

- (void)cancelAllRequests {
	[operationQueue cancelAllOperations];
}

- (void)dealloc {
	[operationQueue cancelAllOperations];
	[operationQueue release];
	[super dealloc];
}


@end
