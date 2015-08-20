//
//  CurveChartCell.m
//  看知
//
//  Created by qianfeng on 15/8/20.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "CurveChartCell.h"
#import "PNChart.h"
#import "PersonDetailModel.h"

@implementation CurveChartCell

- (void)configChart:(NSArray *)array index:(NSInteger)index{
    [self createChart:array index:index];
}

- (void)createChart:(NSArray *)array index:(NSInteger)index{
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 140)];
    lineChart.xLabelFont = [UIFont systemFontOfSize:8];
    lineChart.yLabelFont = [UIFont systemFontOfSize:8];
    
    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *yArray = [NSMutableArray array];
    NSInteger i = 0;
    CGFloat max = CGFLOAT_MIN;
    CGFloat min = CGFLOAT_MAX;
    
    for(Trend *trend in array){
        if(i % 4 == 0){
            NSArray *dateArray = [trend.date componentsSeparatedByString:@"-"];
            [xArray addObject:[NSString stringWithFormat:@"%@/%@", dateArray[1],dateArray[2]]];
            if(index == 0){
                [yArray addObject:[NSNumber numberWithLongLong:[trend.agree longLongValue]]];
            }else if(index == 1){
                [yArray addObject:[NSNumber numberWithLongLong:[trend.follower longLongValue]]];
            }else if(index == 2){
                [yArray addObject:[NSNumber numberWithLongLong:[trend.answer longLongValue]]];
            }
        }
        i++;
        
        if(index == 0){
            if([trend.agree longLongValue] > max){
                max = [trend.agree longLongValue];
            }
            if([trend.agree longLongValue] < min){
                min = [trend.agree longLongValue];
            }
        }else if(index == 1){
            if([trend.follower longLongValue] > max){
                max = [trend.follower longLongValue];
            }
            if([trend.follower longLongValue] < min){
                min = [trend.follower longLongValue];
            }
        }else if(index == 2){
            if([trend.answer longLongValue] > max){
                max = [trend.answer longLongValue];
            }
            if([trend.answer longLongValue] < min){
                min = [trend.answer longLongValue];
            }
        }
    }
    
    [lineChart setXLabels:xArray];
    [lineChart setYFixedValueMin:min];
    [lineChart setYFixedValueMax:max];
    lineChart.showCoordinateAxis = YES;
    
    PNLineChartData *data = [PNLineChartData new];
    if(index == 0){
        data.color = PNBlue;
    }else if(index == 1){
        data.color = PNGreen;
    }else if(index == 2){
        data.color = PNRed;
    }
    data.itemCount = xArray.count;
    data.inflexionPointStyle = PNLineChartPointStyleCircle;
    data.getData = ^(NSUInteger index) {
        NSNumber *number = yArray[index];
        CGFloat y = [number floatValue];
        return [PNLineChartDataItem dataItemWithY:y];
    };
    
    lineChart.chartData = @[data];
    [lineChart strokeChart];
    
    [self.contentView addSubview:lineChart];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
