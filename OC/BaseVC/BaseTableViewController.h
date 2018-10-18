//
//  BaseTableViewController.h
//  FYJ
//
//  Created by issuser on 2018/7/18.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseTableViewController : UITableViewController<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/**
 *  实现此方法为navigationBar添加leftBarButtonItems，要么返回UIView类型的对象，要么返回NSArray类型的对象
 *
 *  @return 基类中实现了此方法默认返回nil
 */
- (id)leftItemViews;
/**
 *  实现此方法为navigationBar添加rightBarButtonItems，要么返回UIView类型的对象，要么返回NSArray类型的对象
 *
 *  @return 基类中实现了此方法默认返回nil
 */
- (id)rightItemViews;
/**
 *  实现此方法决定是否要隐藏navigationBar
 *
 *  @return 基类中实现了此方法默认返回NO
 */
- (BOOL)shouldHideNavigationBar;
/**
 *  实现此方法决定是否显示返回按钮
 *
 *  @return 基类中实现了此方法默认返回YES
 */
- (BOOL)shouldShowBackItem;

- (UITableViewStyle)tableViewStyle;//默认返回UITableViewStylePlain
/**
 *  已经默认实现了此方法，只有需要获取返回事件的时候才重写此方法，但必须调用父类的方法
 *
 *  @param button 点击返回的按钮
 */
- (void)backItemAction:(UIButton*)button;

/**
 设置背景颜色
 */
- (UIColor *)backgroundColor;
/**
 *  如果不想要下拉刷新，子类需要重写这个方法并返回NO
 *
 *  @return 默认为NO
 */
- (BOOL)shouldShowRefresh;
/**
 *  如果不想要上拉加载更多，子类需要重写这个方法并返回NO
 *
 *  @return 默认为NO
 */
- (BOOL)shouldShowGetMore;
/**
 *  子类需要完成重写这个方法，这个方法默认调用finishRequest方法，子类在其请求完成回调后，需要手动调用finishRequest
 */
- (void)requestRefresh;
/**
 *  子类需要完成重写这个方法，这个方法默认调用finishRequest方法，子类在其请求完成回调后，需要手动调用finishRequest
 */
- (void)requestGetMore;
/**
 *  配置列表header和footer刷新数据的UI，已经有默认配置
 */
- (void)configRefreshUI;
/**
 触发刷新刷新动作
 */
- (void)toTriggerRequestRefresh;

/**
 触发上拉加载动作
 */
- (void)toTriggerRequestGetMore;
/**
 请求完成，不管成功或者失败必须手动调用此方法结束刷新动画
 */
- (void)finishRequest;
/**
 设置无数据标题
 */
- (NSString *)titleForEmptyData;
//network
- (void)showNetFailureView;
- (void)hideNetFailureView;
- (void)fresh:(id)sender;
@end
