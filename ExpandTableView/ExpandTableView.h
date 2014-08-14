//
//  ExpandTableView.h
//  ExpandTableView
//
//  Created by Aidan on 8/14/14.
//  Copyright (c) 2014 aidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExpandTableViewDelegate <NSObject>

@optional
/*! Optional method the delegate should implement to get notified when a child is clicked on.
 
 @param childIndex The child index in question
 @param parentIndex The parent index in question
 */
- (void) tableView:(UITableView *)tableView didSelectCellAtChildIndex:(NSInteger) childIndex withInParentCellIndex:(NSInteger) parentIndex;
/*! Optional method the delegate should implement to get notified when a child is clicked on.
 
 @param childIndex The child index in question
 @param parentIndex The parent index in question
 */
- (void) tableView:(UITableView *)tableView didDeselectCellAtChildIndex:(NSInteger) childIndex withInParentCellIndex:(NSInteger) parentIndex;
/*! Optional method to get notified when a parent is clicked on.
 
 @param parentIndex The parent index in question
 */
- (void) tableView:(UITableView *)tableView didSelectParentCellAtIndex:(NSInteger) parentIndex;

@end

@protocol ExpandTableViewDataSource <NSObject>
@required
/*!
 
 @return The total number of parent cells in this table.
 */
- (NSInteger) numberOfParentCells;
/*!
 @param parentIndex The parent index in question
 @return The total number of children cells under each parent in this table.
 */
- (NSInteger) numberOfChildCellsUnderParentIndex:(NSInteger) parentIndex;


@end

@interface ExpandTableView : UIView

@property(strong, nonatomic) id<ExpandTableViewDelegate> delegate;
@property(strong, nonatomic) id<ExpandTableViewDataSource> dataSource;


@end
