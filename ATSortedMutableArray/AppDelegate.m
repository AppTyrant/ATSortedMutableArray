//
//  AppDelegate.m
//  ATSortedMutableArray
//
//  Created by ANTHONY CRUZ on 12/6/18.
//  Copyright © 2018 Writes for All. All rights reserved.
//

#import "AppDelegate.h"
#import "ATSortedMutableArray.h"

@interface AppDelegate () <NSTableViewDataSource,NSTableViewDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (strong) ATSortedMutableArray<NSNumber*>*sortedNumbers;
@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation AppDelegate

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _sortedNumbers = [ATSortedMutableArray sortedArrayWithComparator:^NSComparisonResult(NSNumber *obj1,
                                                                                             NSNumber *obj2)
        {
            return [obj1 compare:obj2];
        }];
    }
    return self;
}

#pragma mark - NSTableViewDataSource/Delegates
-(NSInteger)numberOfRowsInTableView:(NSTableView*)tableView
{
    return self.sortedNumbers.count;
}

-(nullable NSView*)tableView:(NSTableView*)tableView viewForTableColumn:(NSTableColumn*)tableColumn row:(NSInteger)row
{
    static NSString *RowID = @"TableViewRowID";
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:RowID owner:nil];
    NSNumber *number = [self.sortedNumbers objectAtIndex:row];
    cellView.textField.stringValue = [NSString stringWithFormat:@"%lu",number.unsignedIntegerValue];
    return cellView;
}

#pragma mark - IBActions
-(IBAction)addRandomNumber:(id)sender
{
    NSUInteger randomNumber = arc4random_uniform(101);
    NSUInteger indexAdded = [self.sortedNumbers addObject:@(randomNumber)];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:indexAdded] withAnimation:NSTableViewAnimationSlideUp];
    [self.tableView endUpdates];
}

@end
