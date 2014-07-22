//
//  DViewController.m
//  URLNavigation
//
//  Created by Jasper on 14-7-21.
//  Copyright (c) 2014年 Jasper. All rights reserved.
//

#import "DViewController.h"

@interface DViewController ()

@end

@implementation DViewController

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
    back.frame = CGRectMake(100, 100, 50, 50);
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];

    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"下一个" forState:UIControlStateNormal];
    button.frame = CGRectMake(200, 100, 50, 50);
    [button addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"D";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 250, 320, 50);
    [self.view addSubview:label];

}

- (void)jump
{
    [YQNavigator showViewControllerToURL:EVC_URL from:self];
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
