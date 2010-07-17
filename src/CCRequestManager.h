//
//  CCRequestManager.h
//  Scrumers
//
//  Created by Ludovic Galabru on 27/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCRequestOperation;

@interface CCRequestManager : NSObject {
	NSOperationQueue * operationQueue;
}

+ (id)sharedManager;

- (void)processRequestOperation:(CCRequestOperation *)operation;
- (void)cancelAllRequestOperations;

@end
