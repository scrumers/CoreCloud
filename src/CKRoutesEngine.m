//
//  CKRoutesEngine.m
//  CloudKit
//
//  Created by Ludovic Galabru on 08/04/10.
//  Copyright 2010 Software Engineering Task Force. All rights reserved.
//

#import "CKRoutesEngine.h"
#import "NSDictionary+CloudKitAdditions.h"
#import "NSMutableArray+CloudKitAdditions.h"

@interface CKRoutesEngine (Private)

- (NSURL *)URLForKey:(NSString *)key;
- (NSURL *)URLForKey:(NSString *)key withDictionary:(NSDictionary *)newConstants;
- (NSString *)HTTPMethodForKey:(NSString *)key;

- (NSMutableURLRequest *)requestForKey:(NSString *)key;
- (NSMutableURLRequest *)requestForKey:(NSString *)key withDictionary:(NSDictionary *)newConstants;

@end

@implementation CKRoutesEngine

- (id)init {
	self = [super init];
	if (self != nil) {
	}
	return self;
}


- (id)initWithRoutesURL:(NSURL *)URL {
	self = [self init];
	if (self != nil) {
		NSDictionary* plist;
		plist= [NSDictionary dictionaryWithContentsOfURL:URL];
		routes= [[NSDictionary alloc] initWithDictionary:[plist valueForKey:@"routes"]];
		constants= [[NSDictionary alloc] initWithDictionary:[plist valueForKey:@"constants"]];
	}
	return self;
}

- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSDictionary *)params {
	NSString *keyURL= [[*request URL] absoluteString];
	NSURL *processedURL= [self URLForKey:keyURL withDictionary:params];
	[*request setURL:processedURL];
	NSString *method=	[self HTTPMethodForKey:keyURL];
	if (method != nil) {
		[*request setHTTPMethod:method];
	}
}

- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params data:(id *)data andError:(NSError **)error {
}

- (NSURL *)URLForKey:(NSString *)key {
	return [self URLForKey:key withDictionary:nil];
}

- (NSString *)HTTPMethodForKey:(NSString *)key {
	NSString *method;
	method=	[[routes valueForKey:key] valueForKey:@"method"];
	return method;
}

- (NSURL *)URLForKey:(NSString *)key withDictionary:(NSDictionary *)newConstants {
	NSString *rawPath, *processedPath;
	NSDictionary *temporaryConstants;
	NSURL *processedURL;
	temporaryConstants= [NSDictionary dictionaryWithDictionary:constants 
																							 andDictionary:newConstants];
	rawPath= [[routes valueForKey:key] valueForKey:@"url"];
	NSMutableArray *rawComponents= [NSMutableArray arrayWithArray:[rawPath componentsSeparatedByString:@"/"]];
	[rawComponents removeEmptyStrings];
	NSMutableArray *processedComponents= [NSMutableArray array];
	for (id rawComponent in rawComponents) {
		NSArray *rawSubComponents= [rawComponent componentsSeparatedByString:@"."];
		NSMutableArray *processedSubComponents= [NSMutableArray array];
		for (id rawSubComponent in rawSubComponents) {
			if (![rawSubComponent isEqualToString:@""]) {
				if ([rawSubComponent characterAtIndex:0] == ':') {
					NSString *processedSubComponent= [temporaryConstants valueForKey:[rawSubComponent substringFromIndex:1]];
					if (processedSubComponent != nil) {
						[processedSubComponents addObject:processedSubComponent];
					}
				} else {
					[processedSubComponents addObject:rawSubComponent];
				}
			}
		}
		[processedComponents removeEmptyStrings];
		[processedComponents addObject:[processedSubComponents componentsJoinedByString:@"."]];
	}
	processedPath= [processedComponents componentsJoinedByString:@"/"];
	processedURL= [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", processedPath]];
	return processedURL;
}

- (NSMutableURLRequest *)requestForKey:(NSString *)key {
	return [self requestForKey:key withDictionary:nil];
}

- (NSMutableURLRequest *)requestForKey:(NSString *)key withDictionary:(NSDictionary *)newConstants {
	NSMutableURLRequest *request;
	request= [[NSMutableURLRequest alloc] initWithURL:[self URLForKey:key 
																										 withDictionary:newConstants]];
	NSString *method;
	method=	[self HTTPMethodForKey:key];
	if (method != nil) {
		[request setHTTPMethod:method];
	}
	return request;
}

- (void) dealloc {
	[super dealloc];
}


@end
