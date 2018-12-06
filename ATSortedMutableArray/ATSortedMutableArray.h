//  ATSortedMutableArray.h
//  ATSortedMutableArray
//  Created by ANTHONY CRUZ on 12/6/18.
//  Copyright © 2018 Writes for All. All rights reserved.
//Permission is hereby granted, free of charge, to any person obtaining a copy  of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

#import <Foundation/Foundation.h>

@interface ATSortedMutableArray<__covariant ObjectType>  : NSObject <NSFastEnumeration,NSCopying>

/**
 Init an ATSortedMutableArray using the contents of the passed in originalArray.
 @param comparator The comparator the ATSortedMutableArray is to use to enforce a sort order for every insert.
 @param originalArray An NSArray that the ATSortedMutableArray will use as its original contents.
 @param isOriginalArrayAlreadySorted A BOOL that indicates whether or not originalArray is already sorted using comparator. It is a programming error to pass in YES if originalArray is not already sorted using the given comparator.
 @return An ATSortedMutableArray instance.
 */
-(nonnull instancetype)initWithComparator:(NSComparator _Nonnull)comparator
                                 contents:(nonnull NSArray*)originalArray
             isOriginalArrayAlreadySorted:(BOOL)isOriginalArrayAlreadySorted NS_DESIGNATED_INITIALIZER;

/**
 Init an empty ATSortedMutableArray using the given capacity hint.
 */
-(nonnull instancetype)initWithComparator:(NSComparator _Nonnull)comparator
                                 capacity:(NSUInteger)capacity NS_DESIGNATED_INITIALIZER;

/**
 Creates and returns a new ATSortedMutableArray instance using the given comparator.
 */
+(nonnull ATSortedMutableArray*)sortedArrayWithComparator:(NSComparator _Nonnull)comparator;

-(nonnull instancetype)init NS_UNAVAILABLE;

@property (nonatomic,readonly,copy) NSComparator _Nonnull comparator;

/**
 The number of objects in the array.
 */
@property (readonly) NSUInteger count;

/**
 Returns a copy of all the receiver's contents as an NSArray.
 */
@property (nonnull,nonatomic,copy,readonly) NSArray<ObjectType>*nsArrayRepresentation;

/**
 Sends to each object in the array the message identified by a given selector, starting with the first object and continuing through the array to the last object.
 */
-(void)makeObjectsPerformSelector:(SEL _Nonnull)aSelector;

/**
 Sends the aSelector message to each object in the array, starting with the first object and continuing through the array to the last object.
 */
-(void)makeObjectsPerformSelector:(SEL _Nonnull)aSelector withObject:(nullable id)argument;

-(void)enumerateObjectsUsingBlock:(void (NS_NOESCAPE^_Nonnull)(ObjectType _Nonnull obj,
                                                               NSUInteger idx,
                                                               BOOL *_Nonnull stop))block;

-(void)enumerateObjectsWithOptions:(NSEnumerationOptions)opts
                        usingBlock:(void (NS_NOESCAPE^_Nonnull)(ObjectType _Nonnull obj,
                                                                NSUInteger idx,
                                                                BOOL *_Nonnull stop))block;

-(void)enumerateObjectsAtIndexes:(nonnull NSIndexSet*)s
                         options:(NSEnumerationOptions)opts
                      usingBlock:(void (NS_NOESCAPE^_Nonnull)(ObjectType _Nonnull obj,
                                                              NSUInteger idx,
                                                              BOOL *_Nonnull stop))block;

@end

@interface ATSortedMutableArray<__covariant ObjectType> (QueryMethods)

-(NSUInteger)indexOfObject:(nonnull ObjectType)anObject;
-(NSUInteger)indexOfObject:(nonnull ObjectType)anObject inRange:(NSRange)range;
-(NSUInteger)indexOfObjectIdenticalTo:(nonnull ObjectType)anObject;
-(NSUInteger)indexOfObjectIdenticalTo:(nonnull ObjectType)anObject inRange:(NSRange)range;

/**
 Returns the object located at the specified index.
 */
-(nonnull ObjectType)objectAtIndex:(NSUInteger)index;

/**
 Returns an NSArray containing the objects in the array at the indexes specified by a given index set.
 */
-(nonnull NSArray<ObjectType>*)objectsAtIndexes:(nonnull NSIndexSet*)indexes;

/**
 Returns a Boolean value that indicates whether a given object is present in the array.
 */
-(BOOL)containsObject:(nonnull ObjectType)anObject;

/**
 The reciever and the passed in NSArray have equal contents if they each hold the same number of objects and objects at a given index in each array satisfy the isEqual: test.
 */
-(BOOL)hasContentsEqualToNSArray:(nonnull NSArray*)nsArray;

-(NSUInteger)indexOfObjectPassingTest:(BOOL (NS_NOESCAPE^_Nonnull)(ObjectType _Nonnull obj,
                                                                   NSUInteger idx,
                                                                   BOOL *_Nonnull stop))predicate;

-(NSUInteger)indexOfObjectWithOptions:(NSEnumerationOptions)opts
                          passingTest:(BOOL (NS_NOESCAPE^_Nonnull)(ObjectType _Nonnull obj,
                                                                   NSUInteger idx,
                                                                   BOOL *_Nonnull stop))predicate;

-(NSUInteger)indexOfObjectAtIndexes:(nonnull NSIndexSet*)s
                            options:(NSEnumerationOptions)opts
                        passingTest:(BOOL (NS_NOESCAPE^_Nonnull)(ObjectType _Nonnull obj,
                                                                 NSUInteger idx,
                                                                 BOOL *_Nonnull stop))predicate;

-(nonnull NSIndexSet*)indexesOfObjectsPassingTest:(BOOL (NS_NOESCAPE^_Nonnull)(ObjectType _Nonnull obj,
                                                                               NSUInteger idx,
                                                                               BOOL *_Nonnull stop))predicate;

-(nonnull NSIndexSet*)indexesOfObjectsWithOptions:(NSEnumerationOptions)opts
                                      passingTest:(BOOL (NS_NOESCAPE^_Nonnull)(ObjectType _Nonnull obj,
                                                                               NSUInteger idx,
                                                                               BOOL *_Nonnull stop))predicate;

-(nonnull NSIndexSet*)indexesOfObjectsAtIndexes:(nonnull NSIndexSet*)s
                                        options:(NSEnumerationOptions)opts
                                    passingTest:(BOOL (NS_NOESCAPE^_Nonnull)(ObjectType _Nonnull obj,
                                                                             NSUInteger idx,
                                                                             BOOL *_Nonnull stop))predicate;

@end

@interface ATSortedMutableArray<__covariant ObjectType> (ObjectReplacementMethods)

/**
 Calling this method does the following:
 -Removes the object at index.
 -Adds anObject to the array at an index determined by the comparator property.
 -Returns the index of anObject, which may be different from index.
 */
-(NSUInteger)replaceObjectAtIndex:(NSUInteger)index withObject:(nonnull ObjectType)anObject;

@end

@interface ATSortedMutableArray<__covariant ObjectType> (AddObjectMethods)

/**
 Call this method to add the object to the array.
 @return The index where the object was inserted.
 */
-(NSUInteger)addObject:(nonnull ObjectType)objectToInsert;

/**
 Adds all the objects in arrayOfObjects by enumerating through arrayofObjects and calling the -addObject: method on each object.
 */
-(void)addObjectsFromArray:(nonnull NSArray<ObjectType>*)arrayOfObjects;

@end

@interface ATSortedMutableArray<__covariant ObjectType> (RemoveObjectMethods)

/**
 Removes the object with the highest-valued index in the array.
 */
-(void)removeLastObject;

/**
 Removes the object at the given index.
 @param index The index from which to remove the object in the array. The value must not exceed the bounds of the array.
 */
-(void)removeObjectAtIndex:(NSUInteger)index;

/**
 Removes all occurrences in the array of a given object.
 */
-(void)removeObject:(nonnull ObjectType)anObject;

/**
 Empties the array of all its elements.
 */
-(void)removeAllObjects;

/**
 Removes all occurrences within a specified range in the array of a given object.
 */
-(void)removeObject:(nonnull ObjectType)anObject inRange:(NSRange)range;

/**
 Removes all occurrences of anObject within the specified range in the array.
 This method determines a match by comparing the address of anObject to the addresses of objects in the receiver. If the array does not contain anObject within aRange, the method has no effect (although it does incur the overhead of searching the contents).
 */
-(void)removeObjectIdenticalTo:(nonnull ObjectType)anObject inRange:(NSRange)range;

/**
 Removes all occurrences of a given object in the array.
 This method determines a match by comparing the address of anObject to the addresses of objects in the receiver. If the array does not contain anObject within aRange, the method has no effect (although it does incur the overhead of searching the contents).
 */
-(void)removeObjectIdenticalTo:(nonnull ObjectType)anObject;

/**
 This method is similar to removeObject:, but it allows you to efficiently remove large sets of objects with a single operation. If the receiving array does not contain objects in otherArray, the method has no effect (although it does incur the overhead of searching the contents).
 This method assumes that all elements in otherArray respond to hash and isEqual:.
 */
-(void)removeObjectsInArray:(nonnull NSArray<ObjectType>*)otherArray;

/**
 Removes from the array each of the objects within a given range.
 */
-(void)removeObjectsInRange:(NSRange)range;

@end
