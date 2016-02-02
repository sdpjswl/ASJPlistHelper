# ASJPListHelper

Property lists are everywhere in Objective-C. This utility class attempts to simplify working with them. I have added the basic functionality needed to save and retreive data from them.

# Installation (Coming soon)

Cocoapods is the preferred way to install this library. Add this command to your `Podfile`:

```
pod 'ASJPListHelper'
```

# Usage

```objc
- (instancetype)initWithPListFileNamed:(NSString *)name NS_DESIGNATED_INITIALIZER;
```

Use the designated initializer to create an instance. You will also need to provide a valid name for your property list file.

```objc
- (BOOL)save:(id)data;
```

Saves data provided to plist file. This method **will overwrite** any previous data present in the plist. Returns YES if saving is successful.

```objc
- (BOOL)update:(id)data;
```

Similar to `save`, although this method **will not overwrite** previous data present in the plist file and append new data after it. Returns YES if saving is successful.

```objc
@property (readonly, copy, nonatomic) id pListContents;
```

Returns the data saved in the plist file.

### To-do

- Add UI to example project
- Refactor code and make it podworthy
- ~~Look up NSPropertyListSerialization~~
- ~~Allow `id` to be sent to save/update~~

# License

ASJPListHelper is available under the MIT license. See the LICENSE file for more info.
