//
//  CKRequestOperation.m
//  Scrumers
//
//  Created by Ludovic Galabru on 27/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import "CKRequestOperation.h"
#import "CKCloudKitManager.h"
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
		params= [inParams retain];
	}
	return self;
}

+ (id)operationWithRequest:(NSMutableURLRequest *)inRequest 
										params:(NSDictionary *)inParams 
									delegate:(id)inDelegate 
					andCongiguration:(CKCloudKitManager *)inConfiguration {
	CKRequestOperation *operation;
	operation = [[CKRequestOperation alloc] initWithRequest:inRequest 
																									 params:inParams 
																								 delegate:inDelegate
																				 andConfiguration:inConfiguration];
	return [operation autorelease];
}

- (void)main {
	error = nil;
	NSArray *ordered_engines= [configuration ordered_engines];
	for (id engine_name in ordered_engines) {
		id<CKEngine> engine= [configuration engineForKey:engine_name];
		[engine processRequest:&request withParams:params];
	}
	NSHTTPURLResponse * response;
	id rawData = [NSURLConnection sendSynchronousRequest:request 
																			returningResponse:&response 
																									error:&error];
	if (response.statusCode > 400) {
		//errors
	} else {
		for (int index= [ordered_engines count]-1; index >= 0; index--) {
			id<CKEngine> engine= [configuration engineForKey:[ordered_engines objectAtIndex:index]];
			[engine processResponse:&response 
									 withParams:params 
											andData:&rawData];
		}
	}
}

- (void)dealloc {
	[data release];
	[request release];
	[delegate release];
	[super dealloc];
}


@end
