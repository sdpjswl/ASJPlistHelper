//
//  PListHelper.h
//  GolfByJordan
//
//  Created by Sudeep Jaiswal on 12/08/14.
//  Copyright (c) 2014 Sudeep Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PListHelper : NSObject {
    NSString *filename;
}

// update existing plist data
-(void)writeData:(NSArray *)array inPListFileNamed:(NSString *)name;

// replace old data in plist
-(void)modifyUsingData:(NSArray *)array inPListFileNamed:(NSString *)name;

// fetch plist data
-(NSArray *)getContentsOfPlistFileNamed:(NSString *)name;

@end
