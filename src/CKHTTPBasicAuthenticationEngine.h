//
//  SHTTPBasicAuthenticationEngine.h
//  Sprints
//
//  Created by Ludovic Galabru on 07/04/10.
//  Copyright 2010 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CKEngine.h"

@interface CKHTTPBasicAuthenticationEngine : NSObject<CKEngine> {
	NSString *_username, *_password, *_basic_authorization;
}

- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSDictionary *)params;
- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params data:(id *)data andError:(NSError **)error;

@property(nonatomic, retain) NSString *username, *password, *basic_authorization;

@end
