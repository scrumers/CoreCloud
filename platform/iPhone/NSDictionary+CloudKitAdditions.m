//
//  NSDictionary+CloudKitAdditions.m
//  CloudKit
//
//  Created by Ludovic Galabru on 19/05/10.
//  Copyright 2010 scrumers. All rights reserved.
//

#import "NSDictionary+CloudKitAdditions.h"


@implementation NSDictionary (CloudKit)

+ (NSDictionary *)dictionaryWithDictionary:(NSDictionary *)dict1 andDictionary:(NSDictionary *)dict2 {
	NSMutableDictionary *mergedDict;
	mergedDict= [NSDictionary dictionaryWithDictionary:dict1];
	for (id key in [dict2 allKeys]) {
		id value;
		if ([dict2 valueForKey:key] == nil || [dict2 valueForKey:key] == [NSNull null]) {
			value= @"";
		} else {
			value= [dict2 valueForKey:key];
		}
		[mergedDict setValue:value forKey:key];
	}
	return mergedDict;
}

@end
