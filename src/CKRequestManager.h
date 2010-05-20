//
//  CKRequestManager.h
//  Scrumers
//
//  Created by Ludovic Galabru on 27/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CKRequestOperation;

@interface CKRequestManager : NSObject {
	NSOperationQueue * operationQueue;
}

+ (id)sharedManager;

- (void)processRequestOperation:(CKRequestOperation *)operation;
- (void)cancelAllRequestOperations;

@end
