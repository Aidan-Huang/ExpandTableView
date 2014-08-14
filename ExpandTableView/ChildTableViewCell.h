//
//  AHChildTableViewCell.h
//  AHExpendTableView
//
//  Created by Aidan on 8/14/14.
//  Copyright (c) 2014 aidan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

@protocol ChildTableViewCellDelegate <NSObject>
// return total number of children under this parentIndex
- (NSInteger) numberOfChildrenUnderParentIndex:(NSInteger)parentIndex;

// selection state: returns YES if child is in selected state
- (BOOL) isSelectedForChildIndex:(NSInteger)childIndex underParentIndex:(NSInteger)parentIndex;

// notify delegate that a child has just been selected
- (void) didSelectRowAtChildIndex:(NSInteger)childIndex
                         selected:(BOOL)isSwitchedOn
                 underParentIndex:(NSInteger)parentIndex;

// get the label string
- (NSString *) labelForChildIndex:(NSInteger)childIndex underParentIndex:(NSInteger)parentIndex;
// get the icon image
- (UIImage *) iconForChildIndex:(NSInteger)childIndex underParentIndex:(NSInteger)parentIndex;
@end

@interface ChildTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) id<ChildTableViewCellDelegate> childDelegate;
@property(nonatomic,strong) UITableView *insideTableView;
@property(nonatomic) NSInteger parentIndex;


@end
