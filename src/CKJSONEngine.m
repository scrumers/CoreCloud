
//
//  CKJSONEngine.m
//  CloudKit
//
//  Created by Ludovic Galabru on 08/04/10.
//  Copyright 2010 Software Engineering Task Force. All rights reserved.
//

#import "CKJSONEngine.h"
#import "NSObject+YAJL.h"

@implementation CKJSONEngine

- (NSString *)serializeObject:(id)inObject {
	return [inObject yajl_JSONString];
}

- (NSString *)serializeArray:(NSArray *)inArray {
	return [inArray yajl_JSONString];
}

- (NSString *)serializeDictionary:(NSDictionary *)inDictionary {
	return [inDictionary yajl_JSONString];
}

- (id)deserialize:(NSData *)inData error:(NSError **)outError {
	return [inData yajl_JSON];
}

- (id)deserializeAsDictionary:(NSData *)inData error:(NSError **)outError {
	return [inData yajl_JSON];
}

- (id)deserializeAsArray:(NSData *)inData error:(NSError **)outError {
	return [inData yajl_JSON];
}

@end
