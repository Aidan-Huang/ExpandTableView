//
//  AHChildTableViewCell.m
//  AHExpendTableView
//
//  Created by Aidan on 8/14/14.
//  Copyright (c) 2014 aidan. All rights reserved.
//

#import "ChildTableViewCell.h"
#import "ChildTableViewCellCell.h"

#define HEIGHT_FOR_CELL 44.0

@implementation ChildTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.insideTableView = [[UITableView alloc] init];
        self.insideTableView.dataSource = self;
        self.insideTableView.delegate = self;
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [[self contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self.insideTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        self.insideTableView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
//        fgColor = [UIColor darkTextColor];
//        bgColor = [UIColor clearColor];
//        font = [UIFont systemFontOfSize:16.0];
        self.insideTableView.backgroundColor = [UIColor clearColor];
        self.insideTableView.scrollEnabled = NO;
        [self.contentView addSubview:self.insideTableView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// TODO combine set delegate and parentIndex into one method for better safety
- (void) setChildDelegate:(id<ChildTableViewCellDelegate>)delegate {
    _childDelegate = delegate;
    NSInteger numberOfChild = [delegate numberOfChildrenUnderParentIndex:self.parentIndex];
    self.insideTableView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, HEIGHT_FOR_CELL * numberOfChild);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.childDelegate numberOfChildrenUnderParentIndex:self.parentIndex];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ChildTableViewCellCell_Reuse_Id";
    
    ChildTableViewCellCell *cell = (ChildTableViewCellCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ChildTableViewCellCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    } else {
        NSLog(@"reusing existing JKSubTableViewCellCell");
    }
    
//    NSInteger row = [indexPath row];
//    cell.titleLabel.text = [self.delegate labelForChildIndex:row underParentIndex:self.parentIndex];
//    cell.iconImage.image = [self.delegate iconForChildIndex:row underParentIndex:self.parentIndex];
//    cell.selectionIndicatorImg.image = [self selectionIndicatorImgOrDefault];
//    
//    BOOL isRowSelected = [self.delegate isSelectedForChildIndex:row underParentIndex:self.parentIndex];
//    
//    if (isRowSelected) {
//        cell.selectionIndicatorImg.hidden = NO;
//    } else {
//        cell.selectionIndicatorImg.hidden = YES;
//    }
    
//    [cell setCellBackgroundColor:bgColor];
//    [cell setCellForegroundColor:fgColor];
//    [cell.titleLabel setFont:font];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    //[cell setupDisplay];
    return cell;
}



#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HEIGHT_FOR_CELL;
}

@end
