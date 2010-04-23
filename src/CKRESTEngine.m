//
//  CKRESTEngine.m
//  CloudKit
//
//  Created by Ludovic Galabru on 08/04/10.
//  Copyright 2010 Software Engineering Task Force. All rights reserved.
//

#import "CKRESTEngine.h"
#import "objc/runtime.h"
#import "NSString+InflectionSupport.h"

@interface CKRESTEngine (Private)

- (NSString *)localClassnameFor:(NSString *)classname;
- (NSString *)remoteClassnameFor:(NSString *)classname;

@end


@implementation CKRESTEngine

@synthesize
localPrefix= _localPrefix;


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
				[dict setValue:[object performSelector:NSSelectorFromString(propertyName)] forKey:propertyName];
			}
		}
		free(propList);
	}
	return dict;
}


- (NSDictionary *)dictionaryFromObjects:(NSArray *)objects {
	return;
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
	return;
}

- (void) dealloc {
	[_localPrefix release];
	[super dealloc];
}


@end
