//
//  CKJSONEngine.h
//  CloudKit
//
//  Created by Ludovic Galabru on 08/04/10.
//  Copyright 2010 Software Engineering Task Force. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKEngine.h"

@interface CKJSONEngine : NSObject <CKEngine> {

}

- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSDictionary *)params;
- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params andData:(id *)data;

- (NSString *)serializeObject:(id)inObject;
- (NSString *)serializeArray:(NSArray *)inArray;
- (NSString *)serializeDictionary:(NSDictionary *)inDictionary;

- (id)deserialize:(NSData *)inData error:(NSError **)outError;
- (id)deserializeAsDictionary:(NSData *)inData error:(NSError **)outError;
- (id)deserializeAsArray:(NSData *)inData error:(NSError **)outError;

@end
