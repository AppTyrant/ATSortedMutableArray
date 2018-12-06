//
//  ATSortedMutableArray.m
//  ATSortedMutableArray
//
//  Created by ANTHONY CRUZ on 12/6/18.
//  Copyright © 2018 Writes for All. All rights reserved.
//Permission is hereby granted, free of charge, to any person obtaining a copy  of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

#import "ATSortedMutableArray.h"

@interface ATSortedMutableArray()
{
    NSMutableArray *_backingArray;
}

@end

@implementation ATSortedMutableArray

+(ATSortedMutableArray*)sortedArrayWithComparator:(NSComparator)comparator
{
    return [[self alloc]initWithComparator:comparator capacity:0];
}

-(instancetype)initWithComparator:(NSComparator)comparator
                         capacity:(NSUInteger)capacity
{
    self = [super init];
    if (self)
    {
        _backingArray = [NSMutableArray arrayWithCapacity:capacity];
        _comparator = [comparator copy];
    }
    return self;
}

-(instancetype)initWithComparator:(NSComparator)comparator
                         contents:(NSArray*)originalArray
     isOriginalArrayAlreadySorted:(BOOL)isOriginalArrayAlreadySorted
{
    self = [super init];
    if (self)
    {
        _comparator = [comparator copy];
        if (isOriginalArrayAlreadySorted || originalArray.count <= 1)
        {
            _backingArray = [NSMutableArray arrayWithArray:originalArray];
        }
        else
        {
            NSArray *sortedVersion = [originalArray sortedArrayUsingComparator:comparator];
            _backingArray = [NSMutableArray arrayWithArray:sortedVersion];
        }
    }
    return self;
}

-(void)makeObjectsPerformSelector:(SEL)aSelector
{
    [_backingArray makeObjectsPerformSelector:aSelector];
}

-(void)makeObjectsPerformSelector:(SEL)aSelector withObject:(nullable id)argument
{
    [_backingArray makeObjectsPerformSelector:aSelector withObject:argument];
}

#pragma mark - Getters
-(NSArray*)nsArrayRepresentation
{
    return [_backingArray copy];
}

-(NSUInteger)count
{
    return _backingArray.count;
}

#pragma mark - NSFastEnumeration/Enumeration
-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState*)state
                                 objects:(id __unsafe_unretained _Nullable [_Nonnull])buffer
                                   count:(NSUInteger)len
{
    return [_backingArray countByEnumeratingWithState:state objects:buffer count:len];
}

-(void)enumerateObjectsUsingBlock:(void (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [_backingArray enumerateObjectsUsingBlock:block];
}

-(void)enumerateObjectsWithOptions:(NSEnumerationOptions)opts
                        usingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [_backingArray enumerateObjectsWithOptions:opts usingBlock:block];
}

-(void)enumerateObjectsAtIndexes:(NSIndexSet*)s
                         options:(NSEnumerationOptions)opts
                      usingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [_backingArray enumerateObjectsAtIndexes:s options:opts usingBlock:block];
}

#pragma mark - NSCopying
-(id)copyWithZone:(nullable NSZone*)zone
{
    Class class = [self class];
    ATSortedMutableArray *sortedCopy = [[class alloc]initWithComparator:self.comparator
                                                               contents:[_backingArray copy]
                                           isOriginalArrayAlreadySorted:YES];
    return sortedCopy;
}

@end

#pragma mark - Query
@implementation ATSortedMutableArray (QueryMethods)

-(BOOL)containsObject:(id)anObject
{
    return [_backingArray containsObject:anObject];
}

-(BOOL)hasContentsEqualToNSArray:(NSArray*)nsArray
{
    if (_backingArray == nsArray) { return YES; }
    return [_backingArray isEqualToArray:nsArray];
}

-(id)objectAtIndex:(NSUInteger)index
{
    return [_backingArray objectAtIndex:index];
}

-(NSArray*)objectsAtIndexes:(NSIndexSet*)indexes
{
    return  [_backingArray objectsAtIndexes:indexes];
}

-(NSUInteger)indexOfObject:(id)object
{
    NSRange range = NSMakeRange(0, self.count);
    return [self indexOfObject:object inRange:range];
}

-(NSUInteger)indexOfObject:(id)anObject inRange:(NSRange)range
{
    NSUInteger theIndex = [_backingArray indexOfObject:anObject
                                         inSortedRange:range
                                               options:NSBinarySearchingFirstEqual
                                       usingComparator:self.comparator];
    return theIndex;
}

-(NSUInteger)indexOfObjectIdenticalTo:(id)anObject
{
    return [_backingArray indexOfObjectIdenticalTo:anObject];
}

-(NSUInteger)indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    return [_backingArray indexOfObjectIdenticalTo:anObject inRange:range];
}

-(NSUInteger)indexOfObjectPassingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [_backingArray indexOfObjectPassingTest:predicate];
}

-(NSUInteger)indexOfObjectWithOptions:(NSEnumerationOptions)opts
                          passingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [_backingArray indexOfObjectWithOptions:opts passingTest:predicate];
}

-(NSUInteger)indexOfObjectAtIndexes:(NSIndexSet*)s
                            options:(NSEnumerationOptions)opts
                        passingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [_backingArray indexOfObjectAtIndexes:s options:opts passingTest:predicate];
}

-(NSIndexSet*)indexesOfObjectsPassingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [_backingArray indexesOfObjectsPassingTest:predicate];
}

-(NSIndexSet*)indexesOfObjectsWithOptions:(NSEnumerationOptions)opts
                              passingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [_backingArray indexesOfObjectsWithOptions:opts passingTest:predicate];
}

-(NSIndexSet*)indexesOfObjectsAtIndexes:(NSIndexSet*)s
                                options:(NSEnumerationOptions)opts
                            passingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [_backingArray indexesOfObjectsAtIndexes:s
                                            options:opts
                                        passingTest:predicate];
}

@end

#pragma mark - Replace
@implementation ATSortedMutableArray (ObjectReplacementMethods)

-(NSUInteger)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    [_backingArray removeObjectAtIndex:index];
    NSUInteger indexForInsertedObject = [self addObject:anObject];
    return indexForInsertedObject;
}

@end

#pragma mark - Add
@implementation ATSortedMutableArray (AddObjectMethods)

-(NSUInteger)addObject:(id)objectToInsert
{
    NSRange rangeOfObjects = NSMakeRange(0, _backingArray.count);
    NSUInteger insertionIndex = [_backingArray indexOfObject:objectToInsert
                                               inSortedRange:rangeOfObjects
                                                     options:NSBinarySearchingInsertionIndex
                                             usingComparator:self.comparator];
    
    [_backingArray insertObject:objectToInsert atIndex:insertionIndex];
    return insertionIndex;
}

-(void)addObjectsFromArray:(NSArray*)arrayOfObjects
{
    for (id aObjectToAdd in arrayOfObjects)
    {
        [self addObject:aObjectToAdd];
    }
}

@end

#pragma mark - Remove
@implementation ATSortedMutableArray (RemoveObjectMethods)

-(void)removeLastObject
{
    [_backingArray removeLastObject];
}

-(void)removeObjectAtIndex:(NSUInteger)index
{
    [_backingArray removeObjectAtIndex:index];
}

-(void)removeAllObjects
{
    [_backingArray removeAllObjects];
}

-(void)removeObject:(id)anObject inRange:(NSRange)range
{
    [_backingArray removeObject:anObject inRange:range];
}

-(void)removeObject:(id)anObject
{
    [_backingArray removeObject:anObject];
}

-(void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    [_backingArray removeObjectIdenticalTo:anObject inRange:range];
}

-(void)removeObjectIdenticalTo:(id)anObject
{
    [_backingArray removeObjectIdenticalTo:anObject];
}

-(void)removeObjectsInArray:(NSArray*)otherArray
{
    [_backingArray removeObjectsInArray:otherArray];
}

-(void)removeObjectsInRange:(NSRange)range
{
    [_backingArray removeObjectsInRange:range];
}

@end

