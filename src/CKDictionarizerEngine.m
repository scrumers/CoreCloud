//
//  CKDictionarizerEngine.m
//  CloudKit
//
//  Created by Ludovic Galabru on 5/20/10.
//  Copyright 2010 scrumers. All rights reserved.
//

#import "CKDictionarizerEngine.h"
#import "objc/runtime.h"
#import "NSString+InflectionSupport.h"


@interface CKDictionarizerEngine (Private)

- (NSString *)localClassnameFor:(NSString *)classname;
- (NSString *)remoteClassnameFor:(NSString *)classname;

- (id)objectFromDictionary:(NSDictionary *)dictionary;
- (NSArray *)objectsFromDictionaries:(NSArray *)array;

- (NSDictionary *)dictionaryFromObject:(id)object;
- (NSDictionary *)dictionaryFromObjects:(NSArray *)objects;

@end

@implementation CKDictionarizerEngine

@synthesize
localPrefix= _localPrefix;

- (id)initWithLocalPrefix:(NSString *)localPrefix {
	self = [super init];
	if (self != nil) {
		self.localPrefix= localPrefix;
	}
	return self;
}

- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSMutableDictionary **)params {
	id rawBody= [*params valueForKey:@"HTTPBody"];
	if (rawBody != nil) {
		NSDictionary *processedBody;
		if ([rawBody isKindOfClass:[NSArray class]]) {
			processedBody= [self dictionaryFromObjects:rawBody];
		} else {
			processedBody= [self dictionaryFromObject:rawBody];
		}
		[*params setValue:processedBody forKey:@"HTTPBody"];
	}
}

- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params data:(id *)data andError:(NSError **)error; {
	if (*data != nil) {
		if ([*data isKindOfClass:[NSArray class]]) {
			*data= [self objectsFromDictionaries:*data];
		} else {
			*data= [self objectFromDictionary:*data];
		}		
	}
}


- (id)objectFromDictionary:(NSDictionary *)dictionary {
	id remoteObject, localObject;
	NSString *remoteClassname, *localClassname;
	
	remoteClassname= [[dictionary allKeys] lastObject];
	remoteObject= [dictionary valueForKey:remoteClassname];
	
	localClassname= [self localClassnameFor:remoteClassname];
	localObject= [[NSClassFromString(localClassname) alloc] init];
	for (id remoteAttribute in [remoteObject allKeys]) {
		NSString *localAttribute= [[NSString stringWithFormat:@"set_%@:", remoteAttribute] camelize];
		if ([localObject respondsToSelector:NSSelectorFromString(localAttribute)]) {
			[localObject performSelector:NSSelectorFromString(localAttribute) 
												withObject:[remoteObject valueForKey:remoteAttribute]];
		}
	}
	return localObject;
}

- (NSArray *)objectsFromDictionaries:(NSArray *)array {
	NSMutableArray *objects= [NSMutableArray array];
	for (id object in array) {
		[objects addObject:[self objectFromDictionary:object]];
	}
	return objects;
}

- (NSDictionary *)dictionaryFromObject:(id)object {
	NSMutableDictionary *dict= nil;
	if ([object respondsToSelector:@selector(toDictionary)]) {
		dict= [object performSelector:@selector(toDictionary)];
	} else {
		dict = [NSMutableDictionary dictionary];
		unsigned int outCount;
		objc_property_t *propList = class_copyPropertyList([object class], &outCount);
		NSString *propertyName;
		for (int i = 0; i < outCount; i++) {
			objc_property_t * prop = propList + i;
			propertyName = [NSString stringWithCString:property_getName(*prop) encoding:NSUTF8StringEncoding];
			if ([object respondsToSelector:NSSelectorFromString(propertyName)]) {
				//NSString *type = [NSString stringWithCString:property_getAttributes(*prop) encoding:NSUTF8StringEncoding];
				[dict setValue:[object performSelector:NSSelectorFromString(propertyName)] forKey:[propertyName underscore]];
			}
		}
		free(propList);
	}
	return [NSDictionary dictionaryWithObject:dict
																		 forKey:[self remoteClassnameFor:NSStringFromClass([object class])]];
}

- (NSDictionary *)dictionaryFromObjects:(NSArray *)objects {
	return nil;
}

- (NSString *)localClassnameFor:(NSString *)classname {
	NSString *result = [classname camelize];
	result = [result stringByReplacingCharactersInRange:NSMakeRange(0,1) 
																					 withString:[[result substringWithRange:NSMakeRange(0,1)] uppercaseString]];	
	if (self.localPrefix!=nil) {
		result = [self.localPrefix stringByAppendingString:result];
	}
	return result;
}


- (NSString *)remoteClassnameFor:(NSString *)classname {
	NSString *result= classname;
	if (self.localPrefix!=nil) {
		result= [result substringFromIndex:[self.localPrefix length]];
	}
	result = [result lowercaseString];
	return result;
}

- (void) dealloc {
	[_localPrefix release];
	[super dealloc];
}

@end
