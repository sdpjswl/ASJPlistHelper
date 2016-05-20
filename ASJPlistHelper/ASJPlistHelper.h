//
// ASJPlistHelper.h
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

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface ASJPlistHelper : NSObject

/**
 *  Fetch data contained in the plist file.
 */
@property (nullable, readonly, copy, nonatomic) id plistContents;

/**
 *  Checks whether the plist file has anything stored in it.
 */
@property (readonly, nonatomic) BOOL isEmpty;

/**
 *  Fetch path of plist file in the file system.
 */
@property (readonly, copy, nonatomic) NSString *plistPath;

/**
 *  The designated intializer.
 *
 *  @param name Name of the plist file.
 *
 *  @return An instance of ASJPlistHelper.
 */
- (instancetype)initWithPlistNamed:(NSString *)name NS_DESIGNATED_INITIALIZER;

/**
 *  Deletes the plist file.
 *
 *  @param error A pointer to an NSError object.
 *
 *  @return A boolean indicating whether the plist was deleted or not.
 */
- (BOOL)deletePlistWithError:(NSError * _Nullable *)error;

/**
 *  Cannot use init. Use the designated initializer "initWithPlistNamed:".
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 *  Will replace existing data in plist with provided data.
 *
 *  @param data A container object containing data to be replaced.
 *
 *  @return A boolean indicating whether the operation was successful.
 */
- (BOOL)save:(id)data;

/**
 *  Will append provided data to already existing data in the plist.
 *
 *  @param data A container object containing data to be added.
 *
 *  @return A boolean indicating whether the operation was successful.
 */
- (BOOL)update:(id)data;

@end

NS_ASSUME_NONNULL_END
