//
//  CMCoreData.m
//  CoreData
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CMCoreData.h"

@interface CMCoreData ()

@property (strong, nonatomic)NSManagedObjectContext *ctx;

@end

@implementation CMCoreData

- (instancetype)initWithPathForResource:(NSString *)resource ofType:(NSString *)type dbFilePath:(NSString *)dbFilePath
{
    if (self = [super init]) {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:resource ofType:type];

        //1.load data model file
        NSManagedObjectModel *maagedModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL URLWithString:filePath]];

        //2.dispatcher
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:maagedModel];

        //3.database file path
        NSString *dbfile = [NSHomeDirectory() stringByAppendingPathComponent:dbFilePath];
        
        //4.Data storage mode,NSSQLiteStoreType is database way
        NSError *error = nil;
        [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dbfile] options:nil error:&error];
        if (error) {
            _open = NO;
        }else{
            _open = YES;
        }
        //5.context
        _ctx = [[NSManagedObjectContext alloc]init];
        [_ctx setPersistentStoreCoordinator:coordinator];

    }
    return self;
}

- (NSArray *)queryEntityName:(NSString *)entityName predicateFormat:(NSString *)predicate sortDescriptors:(NSArray *)sort Offset:(NSInteger)offset Limit:(NSInteger)limit
{

    //1.create table and requset object
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    //Conditional query
     request.predicate = [NSPredicate predicateWithFormat:predicate];
    
    //order
    request.sortDescriptors = sort;
    
    if (limit != 0) {
        //4.sort query,offset is begin ,limit is query number
        request.fetchOffset = offset;
        request.fetchLimit = limit;
    }

    //2.return query data
    NSArray *result = [_ctx executeFetchRequest:request error:nil];

    return result;

}

- (NSArray *)queryEntityName:(NSString *)entityName
{
    return [self queryEntityName:entityName predicateFormat:nil];
}
- (NSArray *)queryEntityName:(NSString *)entityName predicateFormat:(NSString *)predicate
{
    return [self queryEntityName:entityName predicateFormat:predicate sortDescriptors:nil];
}
- (NSArray *)queryEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sort
{
    return [self queryEntityName:entityName predicateFormat:nil sortDescriptors:sort];
}
- (NSArray *)queryEntityName:(NSString *)entityName predicateFormat:(NSString *)predicate sortDescriptors:(NSArray *)sort
{
   return [self queryEntityName:entityName predicateFormat:predicate sortDescriptors:sort Offset:0 Limit:0];
}
- (NSArray *)queryEntityName:(NSString *)entityName Offset:(NSInteger)offset Limit:(NSInteger)limit
{
    return [self queryEntityName:entityName sortDescriptors:nil Offset:offset Limit:limit];
}
- (NSArray *)queryEntityName:(NSString *)entityName predicateFormat:(NSString *)predicate Offset:(NSInteger)offset Limit:(NSInteger)limit
{
    return [self queryEntityName:entityName predicateFormat:predicate sortDescriptors:nil Offset:offset Limit:limit];
}
- (NSArray *)queryEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sort Offset:(NSInteger)offset Limit:(NSInteger)limit
{
    return [self queryEntityName:entityName predicateFormat:nil sortDescriptors:sort Offset:offset Limit:limit];
}




- (id)operationEntityName:(NSString *)entityName
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_ctx];
}

- (void)insertObject:(NSManagedObject *)model
{
    [_ctx insertObject:model];

}

- (void)deleteObject:(NSManagedObject *)model
{
    [_ctx deleteObject:model];
}


- (BOOL)save
{
    return [_ctx save:nil];
}
@end





















