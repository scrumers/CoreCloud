
//
//  CCJSONEngine.m
//  CoreCloud
//
//  Created by Ludovic Galabru on 08/04/10.
//  Copyright 2010 Software Engineering Task Force. All rights reserved.
//

#import "CCJSONEngine.h"
#import "TouchJSON/TouchJSON.h"

@interface CCJSONEngine (Private)

- (NSString *)serializeObject:(id)inObject;
- (NSString *)serializeArray:(NSArray *)inArray;
- (NSString *)serializeDictionary:(NSDictionary *)inDictionary;

- (id)deserialize:(NSData *)inData error:(NSError **)outError;
- (id)deserializeAsDictionary:(NSData *)inData error:(NSError **)outError;
- (id)deserializeAsArray:(NSData *)inData error:(NSError **)outError;

@end

@implementation CCJSONEngine


- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSMutableDictionary **)params {
	NSString *path;
	path= [[[*request URL] absoluteString] stringByAppendingString:@".json"];
	[*request setURL:[NSURL URLWithString:path]];
	[*request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	if ([*params valueForKey:@"HTTPBody"] != nil) {
		[*request setHTTPBody:(NSData *)[[self serializeDictionary:[*params valueForKey:@"HTTPBody"]] dataUsingEncoding:NSUTF8StringEncoding]];
	}
}

- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params data:(id *)data andError:(NSError **)error {
	*data= [self deserialize:*data error:error];
}

- (NSString *)serializeObject:(id)inObject {
	return (NSString *)[[CJSONSerializer serializer] serializeObject:inObject];
}

- (NSString *)serializeArray:(NSArray *)inArray {
	return (NSString *)[[CJSONSerializer serializer] serializeArray:inArray];
}

- (NSString *)serializeDictionary:(NSDictionary *)inDictionary {
	return (NSString *)[[CJSONSerializer serializer] serializeDictionary:inDictionary];
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
