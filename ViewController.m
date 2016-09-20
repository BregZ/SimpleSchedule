//
//  ViewController.m
//  recurrentDemo
//
//  Created by winstrong on 16/9/20.
//  Copyright © 2016年 winstrong. All rights reserved.
//

#import "ViewController.h"
#import "ZFDateTool.h"
#import "Masonry.h"
#import "ZFScheduleViewCell.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#define FromRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    ZFDateTool *dateTool;
    UIView *weekBox;
    UICollectionView *calendarView;
    UIColor *centerColor;
    UIColor *leftColor;
    UIColor *rightColor;
    UILabel *dateLabel;
    NSInteger selectedDay;
}
@property (nonatomic , strong) NSDate *nowMonthDate;
@property (nonatomic , strong) NSDate *nextMonthDate;
@property (nonatomic , strong) NSDate *lastMonthDate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dateTool = [[ZFDateTool alloc] init];
    
    centerColor = [UIColor redColor];
    leftColor   = [UIColor orangeColor];
    rightColor  = [UIColor purpleColor];
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    weekBox = [[UIView alloc] init];
    weekBox.backgroundColor = [UIColor whiteColor];
    weekBox.layer.borderColor = FromRGB(235, 235, 235).CGColor;
    weekBox.layer.borderWidth = 1;
    [self.view addSubview:weekBox];
    [weekBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@30);
    }];
    
    NSArray *titleArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    CGFloat titleW = ScreenW / 7;
    
    for (int i=0; i<titleArray.count; i++) {
        
        UILabel *titleText = [[UILabel alloc] init];
        titleText.font = [UIFont systemFontOfSize:14];
        titleText.text = titleArray[i];
        titleText.textAlignment = NSTextAlignmentCenter;
        
        if (i==0 || i==6) {
            titleText.textColor = FromRGB(253, 82, 82);
        }
        
        [weekBox addSubview:titleText];
        [titleText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weekBox);
            make.left.equalTo(weekBox).offset(titleW*i);
            make.size.mas_equalTo(CGSizeMake(titleW, 30));
        }];
    }
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(titleW, titleW);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat collectionH = titleW * 6 + 10;
    
    calendarView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 5, 5) collectionViewLayout:layout];
    calendarView.frame = CGRectMake(ScreenW*0, 94, ScreenW, collectionH);
    calendarView.backgroundColor = [UIColor clearColor];
    calendarView.userInteractionEnabled = YES;
    calendarView.delegate = self;
    calendarView.dataSource = self;
    calendarView.pagingEnabled = YES;
    calendarView.bouncesZoom = NO;
    calendarView.bounces = NO;
    calendarView.showsHorizontalScrollIndicator = NO;
    calendarView.showsVerticalScrollIndicator = NO;
    calendarView.contentSize = CGSizeMake(ScreenW*2, collectionH);
    calendarView.contentOffset = CGPointMake(ScreenW*2, 0);
    [calendarView registerClass:[ZFScheduleViewCell class] forCellWithReuseIdentifier:@"aCell"];
    [self.view addSubview:calendarView];
    [calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weekBox.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view );
        make.height.equalTo(@(collectionH));
    }];
    
    dateLabel = [[UILabel alloc] init];
    dateLabel.text = [dateTool dateChangeString:self.nowMonthDate];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(calendarView.mas_bottom);
        make.centerX.equalTo(self.view);
    }];
    
    self.title = [dateTool dateChangeString:self.nowMonthDate];
    
}

#pragma mark ---collection代理---
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;       // 这里设置3个是section是为了转换字体颜色用的，当然你也可以设置更多。
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 42;      // 42个是要固定，原因在第1步说了。
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 以下几行是将纵向排列的Cell数字转成横向排列（这个方法可以应用在很多横向滚动的collectionView上）
    NSInteger dayList = indexPath.row / 6 + 1;
    NSInteger dayNum = [self dayNumberChangeDirection:indexPath.row];
    NSInteger firstDay; // 起始日为星期几
    NSInteger totalDays;// 当前月份共有多少天
    
    ZFScheduleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aCell" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            cell.dayLabel.textColor = leftColor;
            firstDay = [dateTool firstWeekdayInMonth:self.lastMonthDate];
            totalDays= [dateTool totaldaysInMonth:self.lastMonthDate];
            break;
        case 1:
            cell.dayLabel.textColor = centerColor;
            firstDay = [dateTool firstWeekdayInMonth:self.nowMonthDate];
            totalDays= [dateTool totaldaysInMonth:self.nowMonthDate];
            break;
        case 2:
            cell.dayLabel.textColor = rightColor;
            firstDay = [dateTool firstWeekdayInMonth:self.nextMonthDate];
            totalDays= [dateTool totaldaysInMonth:self.nextMonthDate];
            break;
            
        default:
            firstDay = 1;
            totalDays= 30;
            break;
    }
    
    NSInteger numOfFirstDay = dayNum - firstDay;
    
    if (numOfFirstDay < 1 || numOfFirstDay > totalDays) {
        cell.dayLabel.text = @"";
        cell.circleView.hidden = YES;
        cell.backView.hidden = YES;
        cell.redPoint.hidden = YES;
    }else {
        cell.dayLabel.text = [NSString stringWithFormat:@"%li",numOfFirstDay];
        if (selectedDay==numOfFirstDay) {
            cell.backView.hidden = NO; // 被选中的天数显示背景色
        }else {
            cell.backView.hidden = YES;// 避免cell重用后不隐藏背景色
        }
    }
    
    if (dayList == 1 || dayList == 7) {
        cell.dayLabel.textColor = [UIColor grayColor]; // 周六日变灰色
    }else {
        cell.dayLabel.textColor = FromRGB(50, 50, 50); // 保证其他除周六日外的天数不会变灰
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger dayNum = [self dayNumberChangeDirection:indexPath.row];
    NSInteger firstDay = [dateTool firstWeekdayInMonth:self.nowMonthDate];
    NSInteger totalDays= [dateTool totaldaysInMonth:self.nowMonthDate];
    NSInteger numOfFirstDay = dayNum - firstDay;
    if (numOfFirstDay>=1 && numOfFirstDay<=totalDays) {
        selectedDay = numOfFirstDay;
        [calendarView reloadData];
        NSLog(@"选中了第%li个",numOfFirstDay);
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

/**
 *  将纵顺序排列转成横顺序排列
 */
- (NSInteger)dayNumberChangeDirection:(NSInteger)index
{
    //NSInteger index  = indexPath.row;
    NSInteger dayRow = index % 6;
    NSInteger dayList = index / 6 + 1;
    NSInteger dayNum = (6 * dayRow + dayList + dayRow);
    
    return dayNum;
}

#pragma mark ---scroll监听左右滑动---
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float intervalMonth = 0;
    if(scrollView.contentOffset.x<=ScreenW*0)
    {//向右滑
        UIColor *color = centerColor;
        centerColor = leftColor;
        leftColor   = rightColor;
        rightColor  = color;
        
        intervalMonth = scrollView.contentOffset.x / ScreenW - 1;
        NSLog(@"向右滑动了%f个月",intervalMonth);
    }
    if (scrollView.contentOffset.x>=ScreenW*2)
    {//向左划
        UIColor *color = centerColor;
        centerColor = rightColor;
        rightColor  = leftColor;
        leftColor   = color;
        
        intervalMonth = scrollView.contentOffset.x / ScreenW - 1;
        NSLog(@"向左滑动了%f个月",intervalMonth);
    }
    _nowMonthDate = [dateTool intervalMonth:_nowMonthDate intervalNum:intervalMonth];
    
    self.title = [dateTool dateChangeString:self.nowMonthDate];
    dateLabel.text = [dateTool dateChangeString:_nowMonthDate];
    scrollView.contentOffset = CGPointMake(ScreenW, 0);
    [calendarView reloadData];
}

#pragma mark ---月份日期懒加载---
- (NSDate *)nowMonthDate
{
    if (!_nowMonthDate) {
        _nowMonthDate = [NSDate date];
    }
    return _nowMonthDate;
}

- (NSDate *)nextMonthDate
{
    _nextMonthDate = [dateTool nextMonth:self.nowMonthDate intervalMonth:1];
    return _nextMonthDate;
}

- (NSDate *)lastMonthDate
{
    _lastMonthDate = [dateTool lastMonth:self.nowMonthDate intervalMonth:1];
    return _lastMonthDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
