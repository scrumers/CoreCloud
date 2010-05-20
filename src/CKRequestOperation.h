//
//  CKRequestOperation.h
//  Scrumers
//
//  Created by Ludovic Galabru on 27/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CKCloudKitManager;

@interface CKRequestOperation : NSOperation {
	NSMutableURLRequest * request;
	id delegate;
	CKCloudKitManager *configuration;
	NSDictionary *params;
	NSData * data;
	NSError * error;
}

- (id)initWithRequest:(NSMutableURLRequest *)inRequest 
							 params:(NSDictionary *)inParams 
						 delegate:(id)inDelegate 
		 andConfiguration:(CKCloudKitManager *)inConfiguration;

+ (id)operationWithRequest:(NSMutableURLRequest *)inRequest 
										params:(NSDictionary *)inParams 
									delegate:(id)inDelegate 
					andCongiguration:(CKCloudKitManager *)inConfiguration;

@end
