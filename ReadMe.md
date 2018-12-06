# ATSortedMutableArray

A simple, dynamic ordered collection of objects, like NSMutableArray, that enforces a sort order. You create an ATSortedMutableArray with a comparator like this:

```
ATSortedMutableArray *sortedNumbers;
sortedNumbers = [ATSortedMutableArray sortedArrayWithComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2)  {
          return [obj1 compare:obj2];
}];
```

To add an object to the array you use the addObject: method.

```
/**
 Call this method to add an object to the array. 
 @return The index where the object was inserted, which is determined by the comparator property of the receiver.
 */
-(NSUInteger)addObject:(nonnull ObjectType)objectToInsert;
```

This makes it easy to create a sorted collection that will automatically enforce a given sort policy as objects are added. 

You can also add an multiple objects to the array by using the -addObjectsFromArray: method.

```
-(void)addObjectsFromArray:(nonnull NSArray<ObjectType>*)arrayOfObjects;
```
See ATSortedMutableArray.h for more.
