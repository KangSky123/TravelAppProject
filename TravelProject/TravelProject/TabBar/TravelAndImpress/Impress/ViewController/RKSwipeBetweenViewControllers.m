//
//  RKSwipeBetweenViewControllers.m
//  RKSwipeBetweenViewControllers
//
//  Created by Richard Kim on 7/24/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  @cwRichardKim for regular updates

#import "RKSwipeBetweenViewControllers.h"

#define HEIGHT 30
#define SELECTOR_Y_BUFFER 35
#define SELECTOR_HEIGHT 3

@interface RKSwipeBetweenViewControllers ()
{
    UIScrollView *pageScrollView;
    NSInteger currentPageIndex;
    UIButton *button1;
    UIButton *button2;
}

@end

@implementation RKSwipeBetweenViewControllers

-(void)viewWillAppear:(BOOL)animated
{
    [self setupPageViewController];
    [self setupSegmentButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    _viewControllerArray = [[NSMutableArray alloc]init];
    currentPageIndex = 0;
}

//设置SegmentButtons按钮
-(void)setupSegmentButtons
{
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width / 3,HEIGHT)];
    _navigationView.backgroundColor = [UIColor clearColor];
    
    if (!_buttonText) {
         _buttonText = [[NSArray alloc]initWithObjects: @"游记",@"印象",nil];
    }
    
    button1 = [[UIButton alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width /3 / 2, HEIGHT)];
    button1.backgroundColor = [UIColor clearColor];
    [button1 addTarget:self action:@selector(tapSegmentButtonAction1:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:[_buttonText objectAtIndex:0] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_navigationView addSubview:button1];
    
    
    button2 = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width /3 / 2),0, self.view.frame.size.width /3 / 2, HEIGHT)];
    button2.backgroundColor = [UIColor clearColor];
    [button2 addTarget:self action:@selector(tapSegmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:[_buttonText objectAtIndex:1] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_navigationView addSubview:button2];
    
    //将按钮添加到_pageController.navigationController里面
    _pageController.navigationController.navigationBar.topItem.titleView = _navigationView;
    _pageController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self setupSelector];
}

// sets up the selection bar under the buttons on the navigation bar
-(void)setupSelector
{
    _selectionBar = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width /3/4/2), SELECTOR_Y_BUFFER - 1,(self.view.frame.size.width /3 / 4), SELECTOR_HEIGHT)];
    _selectionBar.backgroundColor = [UIColor orangeColor];

    [_navigationView addSubview:_selectionBar];
}


//按钮点击方法
- (void)tapSegmentButtonAction1:(UIButton *)button{
    
    NSInteger tempIndex = currentPageIndex;
    
    __weak typeof(self) weakSelf = self;
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (tempIndex == 1) {
          [_pageController setViewControllers:@[[_viewControllerArray objectAtIndex:tempIndex-1]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL complete){
            if (complete) {
                [weakSelf updateCurrentPageIndex:tempIndex-1.0];
            }
          }];
    }else{
        tempIndex = 1; //防止数组越界
    }
//    NSLog(@"11111qqqq%ld",tempIndex);
}
//按钮点击方法
-(void)tapSegmentButtonAction:(UIButton *)button
{
    NSInteger tempIndex = currentPageIndex;
    
    __weak typeof(self) weakSelf = self;
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (tempIndex == 0) {
        [_pageController setViewControllers:@[[_viewControllerArray objectAtIndex:tempIndex +1]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL complete){
            if (complete) {
                [weakSelf updateCurrentPageIndex:tempIndex +1.0];
            }
        }];
    }else{
        tempIndex = 0;  //防止数组越界
    }
//    NSLog(@"222qqqq%ld",tempIndex);
}
//设置以pageController为导航条
-(void)setupPageViewController
{
    _pageController = (UIPageViewController*)self.topViewController;
//    _pageController.delegate = self;
//    _pageController.dataSource = self;
    [_pageController setViewControllers:@[[_viewControllerArray objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self syncScrollView];
}

//同步ScrollView
-(void)syncScrollView
{
    for (UIView* view in _pageController.view.subviews){
        if([view isKindOfClass:[UIScrollView class]])
        {
            pageScrollView = (UIScrollView *)view;
            pageScrollView.delegate = self;
            pageScrollView.bounces =YES; //关闭回弹效果
        }
    }
}

//记录当前点击的page的下标
-(void)updateCurrentPageIndex:(int)newIndex
{
    currentPageIndex = newIndex;
    NSLog(@"%d",newIndex);
}

//scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xFromCenter = (self.view.frame.size.width /3 )-pageScrollView.contentOffset.x /3;
    NSInteger xCoor = (self.view.frame.size.width /3 / 2)*currentPageIndex;
    _selectionBar.frame = CGRectMake(xCoor-xFromCenter/[_viewControllerArray count] +self.view.frame.size.width /24, _selectionBar.frame.origin.y, (self.view.frame.size.width /3 / 4), SELECTOR_HEIGHT);
}


#pragma mark - Page View Controller Data Source
//// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    if (index == NSNotFound || index == 0) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法，自动来维护次序。
    // 不用我们去操心每个ViewController的顺序问题。
    return [_viewControllerArray objectAtIndex:index];
}

// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [_viewControllerArray count]) {
        return nil;
    }
    return [_viewControllerArray objectAtIndex:index];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        currentPageIndex = [self indexOfController:[pageViewController.viewControllers lastObject]];
    }
}

// 根据数组元素值，得到下标值
-(NSInteger)indexOfController:(UIViewController *)viewController
{
    for (int i = 0; i<[_viewControllerArray count]; i++) {
        if (viewController == [_viewControllerArray objectAtIndex:i])
        {
            return i;
        }
    }
    return NSNotFound;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
