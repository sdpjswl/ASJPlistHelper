//
// ASJPlistHelper.m
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

#import "ASJPlistHelper.h"

static NSString *const kInvalidFilenameMessage = @"Invalid filename; must be of at least 1 character.";
static NSString *const kIncompatibleMessage = @"Data provided is not compatible to be saved. To troubleshoot you can:\n1. Take a look at your data and your plist's root object\n2.Make sure your objects conform to the NSCoding protocol and/or are of these types: NSArray, NSDictionary, NSString, NSData, NSDate, NSNumber.";

typedef NS_ENUM(NSInteger, RootObjectType) {
  RootObjectTypeArray,
  RootObjectTypeDictionary,
  RootObjectTypeNone
};

@interface ASJPlistHelper ()

@property (copy, nonatomic) NSString *filename;
@property (copy, nonatomic) NSString *plistPath;
@property (assign, nonatomic) RootObjectType rootObjectType;
@property (readonly, nonatomic) BOOL fileExists;
@property (readonly, copy, nonatomic) NSArray *rootObjectTypes;
@property (readonly, weak, nonatomic) NSFileManager *fileManager;

- (void)setup;
- (void)createPlistIfNeeded;
- (void)setupRootObjectTypeForData:(id)data;
- (BOOL)updateDataInArrayTypePlist:(id)data;
- (BOOL)updateDataInDictionaryTypePlist:(id)data;
- (BOOL)isDataCompatibleToSave:(id)data;

@end

@implementation ASJPlistHelper

- (instancetype)initWithPlistNamed:(NSString *)name
{
  // validate filename
  NSAssert(name.length, kInvalidFilenameMessage);
  
  self = [super init];
  if (self) {
    _filename = name;
    [self setup];
  }
  return self;
}

- (BOOL)deletePlistWithError:(NSError *__autoreleasing  _Nullable *)error
{
  BOOL isDeletable = [self.fileManager isDeletableFileAtPath:self.plistPath];
  if (!isDeletable) {
    return NO;
  }
  
  return [self.fileManager removeItemAtPath:self.plistPath error:error];
}

#pragma mark - Setup

- (void)setup
{
  _rootObjectType = RootObjectTypeNone;
  [self createPlistIfNeeded];
  
  id contents = self.plistContents;
  [self setupRootObjectTypeForData:contents];
}

- (void)createPlistIfNeeded
{
  if (self.fileExists) {
    return;
  }
  
  BOOL success = [self.fileManager createFileAtPath:self.plistPath contents:nil attributes:nil];
  NSAssert(success, @"Could not create property list file at path: %@", self.plistPath);
}

- (BOOL)fileExists
{
  return [self.fileManager fileExistsAtPath:self.plistPath];
}

- (NSFileManager *)fileManager
{
  return [NSFileManager defaultManager];
}

#pragma mark - Root type

- (void)setupRootObjectTypeForData:(id)data
{
  for (NSString *type in self.rootObjectTypes)
  {
    Class class = NSClassFromString(type);
    if ([data isKindOfClass:class])
    {
      NSInteger idx = [self.rootObjectTypes indexOfObject:type];
      _rootObjectType = (RootObjectType)idx;
    }
  }
}

- (NSArray *)rootObjectTypes
{
  return @[@"NSArray", @"NSDictionary"];
}

#pragma mark - Save

- (BOOL)save:(id)data
{
  BOOL isCompatible = [self isDataCompatibleToSave:data];
  if (!isCompatible) {
    return NO;
  }
  
  if ([data isKindOfClass:[NSDictionary class]])
  {
    _rootObjectType = RootObjectTypeDictionary;
    return [data writeToFile:self.plistPath atomically:YES];
  }
  
  _rootObjectType = RootObjectTypeArray;
  
  if ([data isKindOfClass:[NSArray class]]) {
    return [data writeToFile:self.plistPath atomically:YES];
  }
  
  NSArray *array = [NSArray arrayWithObject:data];
  return [array writeToFile:self.plistPath atomically:YES];
}

#pragma mark - Update

- (BOOL)update:(id)data
{
  BOOL isCompatible = [self isDataCompatibleToSave:data];
  if (!isCompatible) {
    return NO;
  }
  
  // just save if plist is empty
  if (self.isEmpty) {
    return [self save:data];
  }
  
  if (_rootObjectType == RootObjectTypeArray) {
    return [self updateDataInArrayTypePlist:data];
  }
  
  // if root object is of type NSDictionary and we try to save an array it it, it won't be possible. however, an array will be able to take other kinds of objects, including a dictionary. i have already checked if data is plist-eligible at the start
  else if (_rootObjectType == RootObjectTypeDictionary)
  {
    if (![data isKindOfClass:[NSDictionary class]]) {
      return NO;
    }
    
    return [self updateDataInDictionaryTypePlist:data];
  }
  
  return NO;
}

- (BOOL)updateDataInArrayTypePlist:(id)data
{
  NSMutableArray *fileContents = [[NSMutableArray alloc] initWithArray:self.plistContents];
  
  // append objects if root type is array and provided data is too
  if ([data isKindOfClass:[NSArray class]]) {
    [fileContents addObjectsFromArray:data];
  }
  
  // simply add data as another object
  else {
    [fileContents addObject:data];
  }
  
  return [fileContents writeToFile:self.plistPath atomically:YES];
}

- (BOOL)updateDataInDictionaryTypePlist:(id)data
{
  NSMutableDictionary *fileContents = [[NSMutableDictionary alloc] initWithDictionary:self.plistContents];
  
  // append objects if root type is disctionary and provided data is too
  if ([data isKindOfClass:[NSDictionary class]])
  {
    [fileContents addEntriesFromDictionary:data];
  }
  
  return [fileContents writeToFile:self.plistPath atomically:YES];
}

#pragma mark - Helpers

- (BOOL)isDataCompatibleToSave:(id)data
{
  BOOL isCompatible = [NSPropertyListSerialization propertyList:data isValidForFormat:NSPropertyListXMLFormat_v1_0];
  NSAssert(isCompatible, kIncompatibleMessage);
  
  return isCompatible;
}

#pragma mark - Property getters

- (NSString *)plistPath
{
  if (_plistPath) {
    return _plistPath;
  }
  NSString *directoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
  _plistPath = [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", _filename]];
  return _plistPath;
}

- (BOOL)isEmpty
{
  return !self.plistContents;
}

- (id)plistContents
{
  NSData *data = [NSData dataWithContentsOfFile:self.plistPath];
  if (!data.length) {
    return nil;
  }
  
  NSPropertyListFormat format = NSPropertyListXMLFormat_v1_0;
  NSError *error = nil;
  
  id object = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:&format error:&error];
  
  if (error.code == 3840) {
    return nil;
  }
  
  return object;
}

@end
