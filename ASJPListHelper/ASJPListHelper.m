//  ASJPListHelper.m
//
// Copyright (c) 2014 Sudeep Jaiswal
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

@import UIKit;
#import "ASJPListHelper.h"

@interface ASJPListHelper ()

@property (nonatomic) NSString *fileName;

@end

@implementation ASJPListHelper


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
    BOOL doesFileExist = [ASJPListHelper doesFileExistAtPath:pListPath];
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
