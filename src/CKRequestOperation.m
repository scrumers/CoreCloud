//
//  CKRequestOperation.m
//  Scrumers
//
//  Created by Ludovic Galabru on 27/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import "CKRequestOperation.h"
#import "CKCloudKitManager.h"
#import "CKRequestDelegate.h"
#import "CKEngine.h"

@implementation CKRequestOperation



- (id)initWithRequest:(NSMutableURLRequest *)inRequest 
							 params:(NSDictionary *)inParams 
						 delegate:(id)inDelegate 
		 andConfiguration:(CKCloudKitManager *)inConfiguration {
	self = [super init];
	if (self != nil) {
		request = [inRequest retain];
		delegate = [inDelegate retain];
		configuration= [inConfiguration retain];
		params= [[NSMutableDictionary alloc] initWithDictionary:inParams];
	}
	return self;
}

+ (id)operationWithRequest:(NSMutableURLRequest *)inRequest 
										params:(NSDictionary *)inParams 
									delegate:(id)inDelegate 
					andConfiguration:(CKCloudKitManager *)inConfiguration {
	CKRequestOperation *operation;
	operation = [[CKRequestOperation alloc] initWithRequest:inRequest 
																									 params:inParams 
																								 delegate:inDelegate
																				 andConfiguration:inConfiguration];
	return [operation autorelease];
}

- (void)main {
	NSError *error = nil;
	NSArray *ordered_engines= [configuration ordered_engines];
	for (id engine_name in ordered_engines) {
		id<CKEngine> engine= [configuration engineForKey:engine_name];
		[engine processRequest:&request withParams:&params];
	}
	NSLog(@"%@", [request URL]);
	NSLog(@"%@", [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);
	
	NSHTTPURLResponse * response;
	id rawData = [NSURLConnection sendSynchronousRequest:request 
																			returningResponse:&response 
																									error:&error];
	
	if (response.statusCode < 400 && error == nil) {
		for (int index= [ordered_engines count]-1; index >= 0; index--) {
			id<CKEngine> engine= [configuration engineForKey:[ordered_engines objectAtIndex:index]];
			[engine processResponse:&response 
									 withParams:params 
												 data:&rawData
										 andError:&error];
		}
	} else if (response.statusCode > 400) {
		//errors handling
	}
	if (error == nil) {
		[self performSelectorOnMainThread:@selector(requestDidSucceedWithData:) 
													 withObject:rawData
												waitUntilDone:YES];
	} else {
		[self performSelectorOnMainThread:@selector(requestDidFailWithError:) 
													 withObject:error
												waitUntilDone:YES];
	}
}

- (void)requestDidFailWithError:(NSError *)error {
	[delegate request:request didFailWithError:error];
}

- (void)requestDidSucceedWithData:(id)response {
	[delegate request:request didSucceedWithData:response];
}

- (void)dealloc {
	[data release];
	[request release];
	[delegate release];
	[super dealloc];
}


@end
