//
//  AViewController.m
//  URLNavigation
//
//  Created by Jasper on 14-7-21.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import "AViewController.h"
#import "Sample.h"
#import "NSString+YQ.h"
@interface AViewController ()

@end

@implementation AViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeSystem];
    back.backgroundColor = [UIColor grayColor];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    back.frame = CGRectMake(80, 100, 50, 50);
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    
    
    
    

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"下一个" forState:UIControlStateNormal];
    button.frame = CGRectMake(320 - 80 - 50, 100, 50, 50);
    [button addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //人为创建一个对象

    _sample = [[Sample alloc]init];
    _sample.messageID = @123;
    _sample.messageContent = @"hello Jasper";
    
    [_sample syncSave];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"A";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 250, 320, 50);
    [self.view addSubview:label];
    
    
}

- (void)jump
{
    
    //创建URL
    NSString *baseURLforBVC = BVC_URL;
    //增加参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    //这里出了一个小问题，直接存 NSNumber 有点小问题
    [dict setValue:[NSString stringWithFormat:@"%@",_sample.messageID] forKey:@"messageID"];
   
    baseURLforBVC = [baseURLforBVC addUrlFromDictionary:dict];
    [YQNavigator showViewControllerToURL:baseURLforBVC from:self];
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
