# ASJPlistHelper

Property lists, or plists are everywhere in iOS and Mac platforms. They are used to store small amounts of data like default settings/preferences. This library attempts to simplify working with them. It encapsulates the functionality needed to save and retrieve data from them.

Plists generally have two kinds of root objects; `NSArray` or `NSDictionary`. For instance, the `Info.plist` in every Xcode project holds an `NSDictionary`. When using this library, if the current plist you're working with is empty and does not have a root object type, it will be set when you save any data in it.

Suppose you save an `NSDictionary`, that becomes the root object. But if you save any other kind of valid plist object, it will fall back to `NSArray` so that any updatation of the plist in future would mean adding objects to that array.

When trying to update an existing plist with root object type `NSDictionary`, note that you can only update it with another dictionary. Attempting to update with any other object will fail. On the other hand, an existing `NSArray` type plist will be able to update itself with any kind of valid plist object.

# Installation

CocoaPods is the preferred way to install this library. Add this command to your `Podfile`:

```ruby
pod 'ASJPlistHelper'
```

# Usage

```objc
- (instancetype)initWithPlistNamed:(NSString *)name NS_DESIGNATED_INITIALIZER;
```
Use the designated initializer to create an instance. You will also need to provide a valid name for your plist file.

```objc
- (BOOL)save:(id)data;
```

Saves data provided to plist file. This method **will overwrite** any previous data present in the plist. Returns YES if saving is successful.

```objc
- (BOOL)update:(id)data;
```

Similar to `save`, although this method **will not overwrite** previous data present in the plist file and append new data after it. Returns YES if saving is successful.

```objc
@property (readonly, copy, nonatomic) id plistContents;
```

Returns the data saved in the plist file.

```objc
- (BOOL)deletePlistWithError:(NSError * _Nullable *)error;
```

You can delete the plist if you're done with it. To recreate, you must initialize another instance of `ASJPlistHelper`.

# Credits

- iOS Developer Library - [Serializing a Property List](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/PropertyLists/SerializePlist/SerializePlist.html)

# To-do

- ~~Add UI to example project.~~
- ~~Refactor code and make it podworthy.~~
- ~~Look up NSPropertyListSerialization.~~
- ~~Allow `id` to be sent to save/update.~~

# License

`ASJPlistHelper` is available under the MIT license. See the LICENSE file for more info.
