//
//  CCRequestOperation.h
//  Scrumers
//
//  Created by Ludovic Galabru on 27/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCManager;

@protocol CCRequestDelegate;

@interface CCRequestOperation : NSOperation {
	NSMutableURLRequest * request;
	NSObject<CCRequestDelegate> * delegate;
	CCManager *configuration;
	NSMutableDictionary *params;
	NSData * data;
}

- (id)initWithRequest:(NSMutableURLRequest *)inRequest 
							 params:(NSDictionary *)inParams 
						 delegate:(id)inDelegate 
		 andConfiguration:(CCManager *)inConfiguration;

+ (id)operationWithRequest:(NSMutableURLRequest *)inRequest 
										params:(NSDictionary *)inParams 
									delegate:(id)inDelegate 
					andConfiguration:(CCManager *)inConfiguration;

@end
