//
//  CCManager.h
//  Scrumers
//
//  Created by Ludovic Galabru on 25/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCEngine;

@interface CCManager : NSObject {
	NSMutableArray *ordered_engines;
	NSMutableDictionary *engines;
	NSMutableDictionary *droppedEngines;
}

+ (CCManager *)defaultConfiguration;
- (void)addEngine:(NSObject<CCEngine> *)engine withKey:(NSString *)key;
- (NSObject<CCEngine> *)engineForKey:(NSString *)key;
- (void)dropEngineWithKey:(NSString *)key;
- (void)restaureDroppedEngines;

- (void)sendRequest:(NSMutableURLRequest *)request withParams:(NSDictionary *)params andDelegate:(id)delegate;
- (void)sendRequest:(NSMutableURLRequest *)request withParams:(NSDictionary *)params;
- (void)sendRequest:(NSMutableURLRequest *)request;

@property(readonly) NSMutableArray *ordered_engines;

@end
