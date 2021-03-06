//
//  UITableView+DDLoganEventLog.m
//  ThousandsWords
//
//  Created by DDLi on 2019/8/1.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "UITableView+DDLoganEventLog.h"

#import "NSObject+DDSwizzlingMethods.h"

@implementation UITableView (DDLoganEventLog)

+ (void)load {
    [NSObject loganInit];
    [self swizzlingMethodWithOriginalSel:@selector(setDelegate:)
                             swizzledSel:@selector(dd_tableview_setDelegate:)];
}

- (void)dd_tableview_setDelegate:(id<UITableViewDelegate>)delegate {
    [self dd_tableview_setDelegate:delegate];
    
    dd_exchangeMethod([delegate class], @selector(tableView:didSelectRowAtIndexPath:), [self class], @selector(dd_replace_tableView:didSelectRowAtIndexPath:), @selector(dd_add_tableView:didSelectRowAtIndexPath:));
}

- (void)dd_replace_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.className = NSStringFromClass([self class]);
    model.indexPath = [NSString stringWithFormat:@"section=%ld,row=%ld",indexPath.section,indexPath.row] ;
    model.des = @"tableView didSelectRowAtIndexPath";
    model.frame = NSStringFromCGRect(tableView.frame);
    logan(DDEventTableviewDidSelect, [@"" objectToJson:model.mj_keyValues]);
    [self dd_replace_tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)dd_add_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.className = NSStringFromClass([self class]);
    model.indexPath = [NSString stringWithFormat:@"section=%ld,row=%ld",indexPath.section,indexPath.row] ;
    model.des = @"tableView didSelectRowAtIndexPath";
    model.frame = NSStringFromCGRect(tableView.frame);
    logan(DDEventTableviewDidSelect, [@"" objectToJson:model.mj_keyValues]);
}

@end
