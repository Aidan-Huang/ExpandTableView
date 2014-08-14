//
//  ViewController.h
//  ExpandTableView
//
//  Created by Aidan on 8/14/14.
//  Copyright (c) 2014 aidan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandTableView.h"

@interface ViewController : UIViewController <ExpandTableViewDelegate, ExpandTableViewDataSource>

@property(nonatomic,weak) IBOutlet ExpandTableView * expandTableView;

@property(nonatomic,strong) NSMutableArray * dataModelArray;

@end

