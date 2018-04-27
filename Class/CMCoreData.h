//
//  CMCoreData.h
//  CoreData
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CMCoreData : NSObject

/********Core Data encapsulation ******************/

//open or create DataBase isOpen
@property (assign, nonatomic, readonly,getter=isOpen)BOOL open;

//init Class and create SQLit ,this is a must .
- (instancetype)initWithPathForResource:(NSString *)resource ofType:(NSString *)type dbFilePath:(NSString *)dbFilePath;

//database table operation function,for retain model
- (id)operationEntityName:(NSString *)entityName;

//add model to the context
- (void)insertObject:(NSManagedObject *)model;
//delete model
- (void)deleteObject:(NSManagedObject *)model;
//save
- (BOOL)save;

/**
 * this is query tabel data for query、 delete、 update operation,ruturn array.
 * Return the desired data to different constraints.
 *  @param entityName query ENTITY’s name
 *
 */
- (NSArray *)queryEntityName:(NSString *)entityName;
- (NSArray *)queryEntityName:(NSString *)entityName predicateFormat:(NSString *)predicate;
- (NSArray *)queryEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sort;
- (NSArray *)queryEntityName:(NSString *)entityName predicateFormat:(NSString *)predicate sortDescriptors:(NSArray *)sort;
- (NSArray *)queryEntityName:(NSString *)entityName Offset:(NSInteger)offset Limit:(NSInteger)limit;
- (NSArray *)queryEntityName:(NSString *)entityName predicateFormat:(NSString *)predicate Offset:(NSInteger)offset Limit:(NSInteger)limit;
- (NSArray *)queryEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sort Offset:(NSInteger)offset Limit:(NSInteger)limit;
- (NSArray *)queryEntityName:(NSString *)entityName predicateFormat:(NSString *)predicate sortDescriptors:(NSArray *)sort Offset:(NSInteger)offset Limit:(NSInteger)limit;



@end
