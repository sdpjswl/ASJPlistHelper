//
//  PListHelper.m
//  Plist
//
//  Created by Sudeep Jaiswal on 12/08/14.
//  Copyright (c) 2014 Sudeep Jaiswal. All rights reserved.
//

@import UIKit;
#import "PListHelper.h"

@interface PListHelper ()

@property (nonatomic) NSString *fileName;

@end

@implementation PListHelper


#pragma mark - Public methods

- (BOOL)checkIn:(NSArray *)data
inPListFileNamed:(NSString *)name {
    
    if (!_fileName) {
        _fileName = name;
    }
    NSString *pListPath = [self getPlistDocumentDirectoryPath];
    NSLog(@"plist path: %@", pListPath);
    return [data writeToFile:pListPath atomically:YES];
}

- (BOOL)updateExistingDataWith:(NSArray *)data
          inPListFileNamed:(NSString *)name {
    
    if (!_fileName) {
        _fileName = name;
    }
    
    NSString *pListPath = [self getPlistDocumentDirectoryPath];
    NSLog(@"plist path: %@", pListPath);
    NSMutableArray *fileContents = [[NSMutableArray alloc] initWithArray:[self getContentsOfPlistFile]];
    
    BOOL success;
    if (fileContents != nil) {
        [fileContents addObjectsFromArray:data];
        success = [fileContents writeToFile:pListPath atomically:YES];
    }
    else {
        success = [data writeToFile:pListPath atomically:YES];
    }
    return success;
}

- (NSArray *)contentsOfPlistFileNamed:(NSString *)name {
    
    if (!_fileName) {
        _fileName = name;
    }
    return [self getContentsOfPlistFile];
}


#pragma mark - Private methods

- (NSArray *)getContentsOfPlistFile {
    
    NSString *pListPath = [self getPlistDocumentDirectoryPath];
    BOOL doesFileExist = [PListHelper doesFileExistAtPath:pListPath];
    if (doesFileExist) {
        return [NSArray arrayWithContentsOfFile:pListPath];
    }
    return nil;
}

- (NSString *)getPlistDocumentDirectoryPath {
    NSArray *directoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [directoryPath objectAtIndex:0];
    NSString *pListPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", _fileName]];
    return pListPath;
}

+ (BOOL)doesFileExistAtPath:(NSString *)filePath {
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *array = [[NSArray alloc] init];
        BOOL success = [array writeToFile:filePath atomically:YES];
        return success;
    }
    return YES;
}

@end
