//
//  NSManagedObject+KHH.m
//  CardBook
//
//  Created by Sun Ming on 12-10-17.
//  Copyright (c) 2012年 Kinghanhong. All rights reserved.
//

#import "NSManagedObject+KHH.h"

static NSSortDescriptor *nameSort;
@implementation NSManagedObject (KHH)
+ (NSManagedObjectContext *)currentContext {
    
    return [[KHHData sharedData] context];
}

// 在context里创建一个新的object;
+ (id)newObject {
    NSString *name = NSStringFromClass([self class]);
    NSManagedObjectContext *context = [self currentContext];
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:name
                                                            inManagedObjectContext:context];
    NSLog(@"[II] new managed object = %@", obj);
    return obj;
}

// 根据 ID 和 类名 查数据库。此ID不是CoreData OBjectID，而至cardID，companyID等等。
// createIfNone==YES，无则新建
// createIfNone==NO， 无则返回nil；
+ (id)objectByID:(NSNumber *)ID createIfNone:(BOOL)createIfNone {
    return [self objectByKey:@"id" value:ID createIfNone:createIfNone];
}


/*!
 根据 Key-Value 查数据库。
 keyName 和 value 不能为nil，否则返回nil。
 createIfNone==YES，无则新建
 createIfNone==NO， 无则返回nil；
 */
+ (id)objectByKey:(NSString *)keyName value:(id)value createIfNone:(BOOL)createIfNone {
    NSManagedObject *result = nil;
    if (keyName && value) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", keyName, value];
        NSError *error;
        NSString *entityName = NSStringFromClass([self class]);
        //NSLog(@"[II] Entity = %@", entityName);
        NSArray *matches = [self objectArrayByPredicate:predicate
                                        sortDescriptors:nil];
        if (nil == matches) {
            NSLog(@"[EE] fetch entity 出错：%@", error?
                 error.localizedDescription:
                 @"未知错误!!!");
            return result;
        }
        if ([matches count] > 1) {
            NSLog(@"[EE] fetch entity 出错：返回的对象多于一个!");
        }
        result = [matches lastObject];
        if (nil == result && createIfNone) {
            result = [self newObject];
            [result setValue:value forKey:keyName];
        }
    }
    return result;
}

// 根据条件和排序规则查数据库。
// 没有符合条件的返回空数组，出错返回nil。
+ (NSArray *)objectArrayByPredicate:(NSPredicate *)predicate
                    sortDescriptors:(NSArray *)sortDescriptors {
    NSString *entityName = NSStringFromClass([self class]);
   // NSLog(@"[II] Entity = %@", entityName);
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entityName];
    // 查询条件
    if (predicate) {
        req.predicate = predicate;
    }
    // 排序规则
    if ([sortDescriptors count]) {
        req.sortDescriptors = sortDescriptors;
    }

    NSError *error = nil;
    // 查询
    NSArray *array = [[self currentContext] executeFetchRequest:req error:&error];
    if (nil == array) {
        NSString *errorMessage = (error)? error.localizedDescription: @"未知错误!!!";
        NSLog(@"[EE] fetchEntityName 出错：%@", errorMessage);
    }
    return array;
}

+ (NSString *)isNilStr:(NSString *)isNilStr
{
    if ([isNilStr isEqual:[NSNull null]]||[isNilStr isEqual:@""]) {
        return nil;
    }
    return isNilStr;
}

@end
@implementation NSManagedObject (KHHSort)
+ (NSSortDescriptor *)nameSortDescriptor {
    if (!nameSort) {
        nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                      ascending:YES
                                       selector:@selector(localizedCaseInsensitiveCompare:)];
    }   
    return nameSort;
}

+ (NSSortDescriptor *)newCardSortDescriptor{
    NSSortDescriptor *result;
    result = [NSSortDescriptor sortDescriptorWithKey:@"viewed"
                                           ascending:YES
                                            selector:@selector(compare:)];
    return result;
}

@end
