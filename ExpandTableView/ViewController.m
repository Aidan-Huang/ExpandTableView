//
//  ViewController.m
//  ExpandTableView
//
//  Created by Aidan on 8/14/14.
//  Copyright (c) 2014 aidan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initializeSampleDataModel];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.expandTableView.expandDataSource = self;
    self.expandTableView.expandDelegate = self;
    
//    [self.expandTableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initializeSampleDataModel {
    self.dataModelArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    NSMutableArray *parent0 = [NSMutableArray arrayWithObjects:
                               [NSNumber numberWithBool:YES],
                               [NSNumber numberWithBool:NO],
                               [NSNumber numberWithBool:NO],
                               nil];
    NSMutableArray *parent1 = [NSMutableArray arrayWithObjects:
                               [NSNumber numberWithBool:NO],
                               [NSNumber numberWithBool:NO],
                               [NSNumber numberWithBool:NO],
                               nil];
    NSMutableArray *parent2 = [NSMutableArray arrayWithObjects:
                               [NSNumber numberWithBool:NO],
                               [NSNumber numberWithBool:YES],
                               nil];
    NSMutableArray *parent3 = [NSMutableArray arrayWithObjects:
                               [NSNumber numberWithBool:NO],
                               [NSNumber numberWithBool:YES],
                               [NSNumber numberWithBool:NO],
                               nil];
    [self.dataModelArray addObject:parent0];
    [self.dataModelArray addObject:parent1];
    [self.dataModelArray addObject:parent2];
    [self.dataModelArray addObject:parent3];
}

#pragma mark - JKExpandTableViewDelegate

//
- (void) tableView:(UITableView *)tableView didSelectCellAtChildIndex:(NSInteger) childIndex withInParentCellIndex:(NSInteger) parentIndex {
    [[self.dataModelArray objectAtIndex:parentIndex] setObject:[NSNumber numberWithBool:YES] atIndex:childIndex];
    NSLog(@"data array: %@", self.dataModelArray);
}

- (void) tableView:(UITableView *)tableView didDeselectCellAtChildIndex:(NSInteger) childIndex withInParentCellIndex:(NSInteger) parentIndex {
    [[self.dataModelArray objectAtIndex:parentIndex] setObject:[NSNumber numberWithBool:NO] atIndex:childIndex];
    NSLog(@"data array: %@", self.dataModelArray);
}

/*
 - (UIImage *) selectionIndicatorIcon {
 return [UIImage imageNamed:@"green_checkmark"];
 }
 */
#pragma mark - ExpandTableViewDataSource
- (NSInteger) numberOfParentCells {
    return [self.dataModelArray count];
}

- (NSInteger) numberOfChildCellsUnderParentIndex:(NSInteger) parentIndex {
    NSMutableArray *childArray = [self.dataModelArray objectAtIndex:parentIndex];
    return [childArray count];
}

- (NSString *) labelForParentCellAtIndex:(NSInteger) parentIndex {
    return [NSString stringWithFormat:@"parent %ld", parentIndex];
}

- (NSString *) labelForCellAtChildIndex:(NSInteger) childIndex withinParentCellIndex:(NSInteger) parentIndex {
    return [NSString stringWithFormat:@"child %ld of parent %ld", childIndex, parentIndex];
}

- (BOOL) shouldDisplaySelectedStateForCellAtChildIndex:(NSInteger) childIndex withinParentCellIndex:(NSInteger) parentIndex {
    NSMutableArray *childArray = [self.dataModelArray objectAtIndex:parentIndex];
    return [[childArray objectAtIndex:childIndex] boolValue];
}

- (UIImage *) iconForParentCellAtIndex:(NSInteger) parentIndex {
    return [UIImage imageNamed:@"arrow-icon"];
}

- (UIImage *) iconForCellAtChildIndex:(NSInteger) childIndex withinParentCellIndex:(NSInteger) parentIndex {
    if (((childIndex + parentIndex) % 3) == 0) {
        return [UIImage imageNamed:@"heart"];
    } else if ((childIndex % 2) == 0) {
        return [UIImage imageNamed:@"cat"];
    } else {
        return [UIImage imageNamed:@"dog"];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"test";
    
    return cell;


}

@end
