//
//  ExpandTableView.m
//  ExpandTableView
//
//  Created by Aidan on 8/14/14.
//  Copyright (c) 2014 aidan. All rights reserved.
//

#import "ExpandTableView.h"
#import "ChildTableViewCell.h"
#import "ParentTableViewCell.h"

@implementation ExpandTableView

#define HEIGHT_FOR_CELL 44.0

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (NSUInteger) rowForParentIndex:(NSUInteger) parentIndex {
    NSUInteger row = 0;
    NSUInteger currentParentIndex = 0;
    
    if (parentIndex == 0) {
        return 0;
    }
    
    while (currentParentIndex < parentIndex) {
        BOOL expanded = [[self.expansionStates objectAtIndex:currentParentIndex] boolValue];
        if (expanded) {
            row++;
        }
        currentParentIndex++;
        row++;
    }
    return row;
}

- (NSUInteger) parentIndexForRow:(NSUInteger) row {
    NSUInteger parentIndex = -1;
    
    NSUInteger i = 0;
    
    while (i <= row) {
        parentIndex ++;
        i++;
        if ([[self.expansionStates objectAtIndex:parentIndex] boolValue]) {
            i++;
        }
    }
    NSLog(@"parentIndexForRow row: %ld parentIndex: %ld", row, parentIndex);
    return parentIndex;
}

- (BOOL) isExpansionCell:(NSUInteger) row {
    if (row < 1) {
        return NO;
    }
    NSUInteger parentIndex = [self parentIndexForRow:row];
    NSUInteger parentIndex2 = [self parentIndexForRow:(row-1)];
    return (parentIndex == parentIndex2);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // returns sum of parent cells and expanded cells
    NSInteger parentCount = [self.expandDataSource numberOfParentCells];
    NSCountedSet * countedSet = [[NSCountedSet alloc] initWithArray:self.expansionStates];
    NSUInteger expandedParentCount = [countedSet countForObject:@"YES"];
    
    return parentCount + expandedParentCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier_Parent = @"CellReuseId_Parent";
    static NSString *CellIdentifier_Child = @"CellReuseId_Child";
   
    
    NSInteger row = indexPath.row;
    NSUInteger parentIndex = [self parentIndexForRow:row];
    BOOL isExpansionCell = [self isExpansionCell:row];
    
    if (isExpansionCell) {
        
        
            ChildTableViewCell *cell = (ChildTableViewCell *)[self dequeueReusableCellWithIdentifier:CellIdentifier_Child];
        
            if (cell == nil) {
                cell = [[ChildTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_Child];
            } else {
                NSLog(@"reusing existing JKSingleSelectSubTableViewCell");
            }
            
//            if ([self.tableViewDelegate respondsToSelector:@selector(backgroundColor)]) {
//                UIColor * bgColor = [self.tableViewDelegate backgroundColor];
//                [cell setSubTableBackgroundColor:bgColor];
//            }
//            
//            if ([self.tableViewDelegate respondsToSelector:@selector(foregroundColor)]) {
//                UIColor * fgColor = [self.tableViewDelegate foregroundColor];
//                [cell setSubTableForegroundColor:fgColor];
//            }
//            
//            if ([self.tableViewDelegate respondsToSelector:@selector(selectionIndicatorIcon)]) {
//                [cell setSelectionIndicatorImg:[self.tableViewDelegate selectionIndicatorIcon]];
//            }
//            
//            if ([self.tableViewDelegate respondsToSelector:@selector(fontForChildren)]) {
//                UIFont *font = [self.tableViewDelegate fontForChildren];
//                [cell setSubTableFont:font];
//            }
        
            NSLog(@"cellForRowAtIndexPath SingleSelect parentIndex: %ld", parentIndex);
            cell.parentIndex = parentIndex;
            //[cell setDelegate:self];
            //[cell reload];
            return cell;
        
    } else {
        // regular parent cell
        ParentTableViewCell *cell = (ParentTableViewCell *)[self dequeueReusableCellWithIdentifier:CellIdentifier_Parent];
        if (cell == nil) {
            cell = [[ParentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_Parent];
        } else {
            NSLog(@"reusing existing JKParentTableViewCell");
        }
        
//        if ([self.tableViewDelegate respondsToSelector:@selector(backgroundColor)]) {
//            UIColor * bgColor = [self.tableViewDelegate backgroundColor];
//            [cell setCellBackgroundColor:bgColor];
//        }
//        
//        if ([self.tableViewDelegate respondsToSelector:@selector(foregroundColor)]) {
//            UIColor * fgColor = [self.tableViewDelegate foregroundColor];
//            [cell setCellForegroundColor:fgColor];
//        }
//        
//        if ([self.tableViewDelegate respondsToSelector:@selector(selectionIndicatorIcon)]) {
//            [cell setSelectionIndicatorImg:[self.tableViewDelegate selectionIndicatorIcon]];
//        }
//        
//        if ([self.tableViewDelegate respondsToSelector:@selector(fontForParents)]) {
//            UIFont * font = [self.tableViewDelegate fontForParents];
//            [cell.label setFont:font];
//        }
        
        NSString * labelStr = [self.expandDataSource labelForParentCellAtIndex:parentIndex];
        cell.textLabel.text = labelStr;
//
//        if ([self.dataSourceDelegate respondsToSelector:@selector(iconForParentCellAtIndex:)]) {
//            UIImage *icon = [self.dataSourceDelegate iconForParentCellAtIndex:parentIndex];
//            [[cell iconImage] setImage:icon];
//        }
        
        cell.parentIndex = parentIndex;
        //[cell selectionIndicatorState:[self hasSelectedChild:parentIndex]];
        //[cell setupDisplay];
        
        return cell;
    }
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSLog(@"heightForRowAtIndexPath row: %ld", row);
    
    
    // if cell is expanded, the cell height would be a multiple of the number of child cells
    BOOL isExpansionCell = [self isExpansionCell:row];
    if (isExpansionCell) {
        NSInteger parentIndex = [self parentIndexForRow:row];
        NSInteger numberOfChildren = [self.expandDataSource numberOfChildCellsUnderParentIndex:parentIndex];
        return HEIGHT_FOR_CELL * numberOfChildren;
    } else {
        return HEIGHT_FOR_CELL;
    }
}

@end
