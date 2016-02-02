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

#import "ASJPListHelper.h"

@interface ASJPListHelper ()

@property (copy, nonatomic) NSString *filename;
@property (readonly, nonatomic) BOOL fileExists;
@property (readonly, copy, nonatomic) NSArray *rootObjectTypes;
@property (copy, nonatomic) NSString *pListPath;
@property (weak, nonatomic) NSFileManager *fileManager;

- (void)setup;
- (BOOL)isDataOfRootObjectType:(id)data;

@end

@implementation ASJPListHelper

- (instancetype)initWithPListFileNamed:(NSString *)name
{
  self = [super init];
  if (self) {
    _filename = name;
    [self setup];
  }
  return self;
}

#pragma mark - Setup

- (void)setup
{
  // validate filename
  NSAssert(_filename.length > 0, @"Invalid filename; must be of at least 1 character.");
  
  // create file if it does not exist
  if (!self.fileExists)
  {
    BOOL success = [self.fileManager createFileAtPath:self.pListPath contents:nil attributes:nil];
    NSAssert(success, @"Could not create property list file at path: %@", self.pListPath);
  }
}

- (BOOL)fileExists
{
  return [self.fileManager fileExistsAtPath:self.pListPath];
}

- (NSFileManager *)fileManager
{
  return [NSFileManager defaultManager];
}

#pragma mark - Operations

- (BOOL)save:(id)data
{
  BOOL isValid = [NSPropertyListSerialization propertyList:data isValidForFormat:NSPropertyListXMLFormat_v1_0];
  if (!isValid) {
    return isValid;
  }
  
#warning i think the types of root object and data should match, otherwise data cannot be added. also, if plist is empty, fall back to array root object.
  BOOL isRootObjectType = [self isDataOfRootObjectType:data];
  
  if (self.isEmpty) {
    
  }
  return [data writeToFile:self.pListPath atomically:YES];
}

- (BOOL)isDataOfRootObjectType:(id)data
{
  BOOL isRootType = NO;
  for (NSString *rootType in self.rootObjectTypes)
  {
    NSString *className = NSStringFromClass([data class]);
    if ([className isEqualToString:rootType]) {
      isRootType = YES;
      break;
    }
  }
  return isRootType;
}

- (BOOL)update:(id)data
{
#warning what if the main kind is dict and we pass array. or the other way around? how to mutate dicts?
#warning cannot hardcode to nsarray
#warning https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/PropertyLists/SerializePlist/SerializePlist.html
#warning root object is either an array or dict
  
  BOOL isValid = [NSPropertyListSerialization propertyList:data isValidForFormat:NSPropertyListXMLFormat_v1_0];
  if (!isValid) {
    return isValid;
  }
  
  
  NSMutableArray *fileContents = [[NSMutableArray alloc] initWithArray:self.pListContents];
  
  BOOL success;
  if (fileContents != nil) {
    [fileContents addObjectsFromArray:data];
    success = [fileContents writeToFile:self.pListPath atomically:YES];
  }
  else {
    success = [data writeToFile:self.pListPath atomically:YES];
  }
  return success;
}

#pragma mark - Property getters

- (id)pListContents
{
  NSData *data = [NSData dataWithContentsOfFile:self.pListPath];
  if (!data) {
    return nil;
  }
  
  NSPropertyListFormat format = NSPropertyListXMLFormat_v1_0;
  NSError *error = nil;
  
  id object = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:&format error:&error];
  return object;
}

- (NSString *)pListPath
{
  if (_pListPath) {
    return _pListPath;
  }
  NSString *directoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
  _pListPath = [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", _filename]];
  return _pListPath;
}

- (BOOL)isEmpty
{
  return !self.pListContents;
}

- (NSArray *)rootObjectTypes
{
  return @[@"NSArray", @"NSDictionary"];
}

@end
