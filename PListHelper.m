//
//  PListHelper.m
//  GolfByJordan
//
//  Created by Sudeep Jaiswal on 12/08/14.
//  Copyright (c) 2014 Sudeep Jaiswal. All rights reserved.
//

#import "PListHelper.h"

@implementation PListHelper


#pragma mark - Public method

-(void)modifyUsingData:(NSArray *)array inPListFileNamed:(NSString *)name {
    
    if (filename == nil) {
        filename = name;
    }
    
    NSString *pListPath = [self getPlistDocumentDirectoryPath];
    [array writeToFile:pListPath atomically:YES];
}

-(void)writeData:(NSArray *)array inPListFileNamed:(NSString *)name {
    
    if (filename == nil) {
        filename = name;
    }
    
    NSString *pListPath = [self getPlistDocumentDirectoryPath];
    NSLog(@"plist path: %@", pListPath);
    NSMutableArray *fileContents = [[NSMutableArray alloc] initWithArray:[self getContentsOfPlistFile]];
    
    if (fileContents != nil) {
        [fileContents addObjectsFromArray:array];
        [fileContents writeToFile:pListPath atomically:YES];
    }
    else {
        [array writeToFile:pListPath atomically:YES];
    }
}

-(NSArray *)getContentsOfPlistFileNamed:(NSString *)name {
    
    if (filename == nil) {
        filename = name;
    }
    return [self getContentsOfPlistFile];
}


#pragma mark - Private methods

-(NSString *)getPlistDocumentDirectoryPath {
    NSArray *directoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [directoryPath objectAtIndex:0];
    NSString *pListPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", filename]];
    return pListPath;
}

-(NSArray *)getContentsOfPlistFile {
    
    NSString *pListPath = [self getPlistDocumentDirectoryPath];
    
    if ([self doesFileExistAtPath:pListPath]) {
        NSArray *fileContents = [NSArray arrayWithContentsOfFile:pListPath];
        return fileContents;
    }
    return nil;
}

-(BOOL)doesFileExistAtPath:(NSString *)filePath {
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        NSError *error;
        NSString *localPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", filename]];
        [[NSFileManager defaultManager] copyItemAtPath:localPath toPath:filePath error:&error];
        
        if (error) {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlert show];
            return NO;
        }
    }
    return YES;
}

@end
