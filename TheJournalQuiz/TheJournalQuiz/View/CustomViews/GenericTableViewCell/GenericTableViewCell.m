//
//  GenericTableViewCell.m
//  TheJournalQuiz
//
//  Created by Kumar on 14/10/15.
//  Copyright (c) 2015 Kumar. All rights reserved.
//


#import "GenericTableViewCell.h"

@implementation GenericTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//+ (CGFloat)rowHeightForData:(id)aData tableView:(UITableView*)aTableView indexPath:(NSIndexPath *)anIndexPath controller:(id)controller {
////    self.data = aData;
////    self.indexPath = anIndexPath;
////    self.tableView = aTableView;
//    
//    return 44;
//}

- (void)createCellForData:(id)aData tableView:(UITableView *)aTableView indexPath:(NSIndexPath *)anIndexPath controller:(id)controller {
    self.data = aData;
    self.indexPath = anIndexPath;
    self.tableView = aTableView;
    self.controller = controller;
}

@end
