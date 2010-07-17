//
//  SOAuthEngine.h
//  Sprints
//
//  Created by Ludovic Galabru on 07/04/10.
//  Copyright 2010 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CCEngine.h"

@class OAToken;
@class OAConsumer;
@protocol OASignatureProviding;

@interface CCOAuthEngine : NSObject<CCEngine> {
	OAToken * _token;
	OAConsumer * _consumer;
	id <OASignatureProviding, NSObject> _signatureProvider;
}

- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSMutableDictionary **)params;
- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params data:(id *)data andError:(NSError **)error;


@property(nonatomic, retain) OAToken * token;
@property(nonatomic, retain) OAConsumer * consumer;
@property(nonatomic, retain) id <OASignatureProviding, NSObject> signatureProvider;

@end
