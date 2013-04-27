//
//  KHHApp.m
//  CardBook
//
//  Created by CJK on 13-3-14.
//  Copyright (c) 2012年 Kinghanhong. All rights reserved.
//

#import "KHHApp.h"

@implementation KHHApp
// Returns the URL to the application's Documents directory.
+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
