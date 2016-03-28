//
//  RKSwipeBetweenViewControllers.h
//  RKSwipeBetweenViewControllers
//
//  Created by Richard Kim on 7/24/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

//@protocol RKSwipeBetweenViewControllersDelegate <NSObject>
//
//@end

#import <UIKit/UIKit.h>

@interface RKSwipeBetweenViewControllers : UINavigationController <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *viewControllerArray;
//@property (nonatomic, weak) id<RKSwipeBetweenViewControllersDelegate> navDelegate;
@property (nonatomic, strong) UIView *selectionBar;
//@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong)UIPageViewController *pageController;
@property (nonatomic, strong)UIView *navigationView;
@property (nonatomic, strong)NSArray *buttonText;

@end
