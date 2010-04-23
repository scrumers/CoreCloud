//
//  CKInstanciationEngine.h
//  CloudKit
//
//  Created by Ludovic Galabru on 08/04/10.
//  Copyright 2010 Software Engineering Task Force. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CKInstanciationEngine

- (id)objectFromDictionary:(NSDictionary *)dictionary;
- (NSArray *)objectsFromDictionaries:(NSArray *)array;

- (NSDictionary *)dictionaryFromObject:(id)object;
- (NSDictionary *)dictionaryFromObjects:(NSArray *)objects;

@end
