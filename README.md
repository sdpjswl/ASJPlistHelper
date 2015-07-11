ASJPListHelper
==============

Property lists are everywhere in Objective-C. This utility class attempts to simplify working with them. I have added the basic functionality needed to save and retreive data from them.

`- (BOOL)checkIn:(NSArray *)data inPListFileNamed:(NSString *)name;`

Saves data you provide in a a plist of the specified name. This method **will overwrite** any previous data present in the plist so be careful! Returns YES if saving is successful.

`- (BOOL)updateExistingDataWith:(NSArray *)data inPListFileNamed:(NSString *)name;`

Similar to `checkIn`, you have to provide the data and the name of you plist. This method **will not overwrite** previous data present in the file and append new data after it. Returns YES if saving is successful.

`- (NSArray *)contentsOfPlistFileNamed:(NSString *)name;`

Returns the data saved in the plist of the name specified.

# License

```
 Copyright (c) 2014 Sudeep Jaiswal

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
```
