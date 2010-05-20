
//
//  CKJSONEngine.m
//  CloudKit
//
//  Created by Ludovic Galabru on 08/04/10.
//  Copyright 2010 Software Engineering Task Force. All rights reserved.
//

#import "CKJSONEngine.h"
#import "TouchJSON/TouchJSON.h"

@implementation CKJSONEngine


- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSDictionary *)params {
	NSString *path;
	path= [[[*request URL] absoluteString] stringByAppendingString:@".json"];
	[*request setURL:[NSURL URLWithString:path]];
	[*request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}

- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params andData:(id *)data {
	NSError *error= nil;
	*data= [self deserialize:*data error:&error];
	NSLog(@"Response:%@", *data);
}

- (NSString *)serializeObject:(id)inObject {
	return [[CJSONSerializer serializer] serializeObject:inObject];
}

- (NSString *)serializeArray:(NSArray *)inArray {
	return [[CJSONSerializer serializer] serializeArray:inArray];
}

- (NSString *)serializeDictionary:(NSDictionary *)inDictionary {
	return [[CJSONSerializer serializer] serializeDictionary:inDictionary];
}

- (id)deserialize:(NSData *)inData error:(NSError **)outError {
	return [[CJSONDeserializer deserializer] deserialize:inData error:outError];
}

- (id)deserializeAsDictionary:(NSData *)inData error:(NSError **)outError {
	return [[CJSONDeserializer deserializer] deserializeAsDictionary:inData error:outError];
}

- (id)deserializeAsArray:(NSData *)inData error:(NSError **)outError {
	return [[CJSONDeserializer deserializer] deserializeAsArray:inData error:outError];
}

@end
