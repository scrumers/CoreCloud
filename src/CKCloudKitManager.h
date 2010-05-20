//
//  CKCloudKitManager.h
//  Scrumers
//
//  Created by Ludovic Galabru on 25/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CKEngine;

@interface CKCloudKitManager : NSObject {
	NSMutableArray *ordered_engines;
	NSMutableDictionary *engines;
}

+ (CKCloudKitManager *)defaultConfiguration;
- (void)addEngine:(NSObject<CKEngine> *)engine withKey:(NSString *)key;
- (NSObject<CKEngine> *)engineForKey:(NSString *)key;

- (void)sendRequest:(NSMutableURLRequest *)request withParams:(NSDictionary *)params andDelegate:(id)delegate;
- (void)sendRequest:(NSMutableURLRequest *)request withParams:(NSDictionary *)params;
- (void)sendRequest:(NSMutableURLRequest *)request;

@property(readonly) NSMutableArray *ordered_engines;

@end
