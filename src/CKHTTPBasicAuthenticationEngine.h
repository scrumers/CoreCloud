//
//  SHTTPBasicAuthenticationEngine.h
//  Sprints
//
//  Created by Ludovic Galabru on 07/04/10.
//  Copyright 2010 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CKAuthenticationEngine.h"

@interface CKHTTPBasicAuthenticationEngine : NSObject<CKAuthenticationEngine> {
	NSString *_username, *_password, *_basic_authorization;
}

- (void)setupWithDictionary:(NSDictionary *)dictionary; 
- (NSMutableURLRequest *)signRequest:(NSMutableURLRequest *)request;

@property(nonatomic, retain) NSString *username, *password, *basic_authorization;

@end
