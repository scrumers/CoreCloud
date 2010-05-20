//
//  SOAuthEngine.h
//  Sprints
//
//  Created by Ludovic Galabru on 07/04/10.
//  Copyright 2010 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CKEngine.h"

@class OAToken;
@class OAConsumer;
@protocol OASignatureProviding;

@interface CKOAuthEngine : NSObject<CKEngine> {
	OAToken * _token;
	OAConsumer * _consumer;
	id <OASignatureProviding, NSObject> _signatureProvider;
}

- (void)setupWithDictionary:(NSDictionary *)dictionary; 
- (NSMutableURLRequest *)signRequest:(NSMutableURLRequest *)request;

@property(nonatomic, retain) OAToken * token;
@property(nonatomic, retain) OAConsumer * consumer;
@property(nonatomic, retain) id <OASignatureProviding, NSObject> signatureProvider;

@end
