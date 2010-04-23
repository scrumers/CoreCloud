//
//  CKRequestOperation.m
//  Scrumers
//
//  Created by Ludovic Galabru on 27/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import "CKRequestOperation.h"
#import "CKCloudKitManager.h"

@implementation CKRequestOperation

- (id)initWithRequest:(NSMutableURLRequest *)inRequest andDelegate:(id)inDelegate {
	self = [super init];
	if (self != nil) {
		request = [[[CKCloudKitManager defaultConfiguration] signRequest:inRequest] retain];
		delegate = [inDelegate retain];
	}
	return self;
}

+ (id)operationWithRequest:(NSMutableURLRequest *)inRequest andDelegate:(id)inDelegate {
	CKRequestOperation * operation;
	operation = [[CKRequestOperation alloc] initWithRequest:inRequest andDelegate:inDelegate];
	return [operation autorelease];
}

- (void)main {
	error = nil;
	NSHTTPURLResponse * response;
	NSLog(@"%@", [request URL]);
	NSLog(@"%@", [request allHTTPHeaderFields]);
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	NSData * raw = [NSURLConnection sendSynchronousRequest:request 
										 returningResponse:&response 
													 error:&error];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	if(response.statusCode == 401 || response.statusCode == 403) {
		//error = [NSError unauthorizedError];
	} else if (response.statusCode == 404) {
		//error = [NSError notFoundError];
	} else if (response.statusCode == 422) {
		//error = [NSError unprocessableEntityError];
	}
	if (error == nil) {
		NSObject<CKSerializationEngine> *serializationEngine;
		serializationEngine= [[CKCloudKitManager defaultConfiguration] serializationEngine];
		data = [[serializationEngine deserialize:raw error:&error] retain];
		
		/*
		NSObject<CKInstanciationEngine> *instanciationEngine;
		serializationEngine= [[CKCloudKitManager defaultConfiguration] instanciationEngine];
		data = [[instanciationEngine deserialize:raw error:&error] retain];
		*/
		
		if (error == nil) {
			[self performSelectorOnMainThread:@selector(returnSuccess:) 
								   withObject:nil 
								waitUntilDone:YES];
			return;
		}
	}
	[self performSelectorOnMainThread:@selector(returnError:) 
						   withObject:nil 
						waitUntilDone:YES];
}

- (void)returnError:(id)sender {
	[delegate request:request didFailWithError:error];
}

- (void)returnSuccess:(id)sender {
	[delegate request:request didFinishWithData:data];
}

- (void)dealloc {
	[data release];
	[request release];
	[delegate release];
	[super dealloc];
}


@end
