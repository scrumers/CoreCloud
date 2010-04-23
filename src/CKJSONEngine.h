//
//  CKJSONEngine.h
//  CloudKit
//
//  Created by Ludovic Galabru on 08/04/10.
//  Copyright 2010 Software Engineering Task Force. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKSerializationEngine.h"

@interface CKJSONEngine : NSObject <CKSerializationEngine> {

}

- (NSString *)serializeObject:(id)inObject;
- (NSString *)serializeArray:(NSArray *)inArray;
- (NSString *)serializeDictionary:(NSDictionary *)inDictionary;

- (id)deserialize:(NSData *)inData error:(NSError **)outError;
- (id)deserializeAsDictionary:(NSData *)inData error:(NSError **)outError;
- (id)deserializeAsArray:(NSData *)inData error:(NSError **)outError;

@end
