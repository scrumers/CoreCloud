//
//  CKRESTEngine.h
//  CloudKit
//
//  Created by Ludovic Galabru on 08/04/10.
//  Copyright 2010 Software Engineering Task Force. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKInstanciationEngine.h"

@interface CKRESTEngine : NSObject <CKInstanciationEngine> {
	NSString *_localPrefix;
}

- (id)objectFromDictionary:(NSDictionary *)dictionary;
- (NSArray *)objectsFromDictionaries:(NSArray *)array;

- (NSDictionary *)dictionaryFromObject:(id)object;
- (NSDictionary *)dictionaryFromObjects:(NSArray *)objects;

@property(nonatomic, retain)	NSString *localPrefix;

@end
