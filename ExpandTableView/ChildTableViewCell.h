//
//  AHChildTableViewCell.h
//  AHExpendTableView
//
//  Created by Aidan on 8/14/14.
//  Copyright (c) 2014 aidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) UITableView *insideTableView;
@property(nonatomic) NSInteger parentIndex;


@end
