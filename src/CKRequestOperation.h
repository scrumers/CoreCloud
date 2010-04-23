//
//  CKRequestOperation.h
//  Scrumers
//
//  Created by Ludovic Galabru on 27/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CKRequestOperation : NSOperation {
	NSMutableURLRequest * request;
	id delegate;
	NSData * data;
	NSError * error;
}

- (id)initWithRequest:(NSMutableURLRequest *)inRequest andDelegate:(id)inDelegate;
+ (id)operationWithRequest:(NSMutableURLRequest *)inRequest andDelegate:(id)inDelegate;

@end
