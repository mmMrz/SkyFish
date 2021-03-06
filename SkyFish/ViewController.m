//
//  ViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/20.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "ViewController.h"
#import "LeftMenuViewController.h"
#import "ChatRecentViewController.h"
#import "LoginViewController.h"

@interface ViewController (){
    
    UINavigationController *fishLocationNAV,*SNSNav,*chatRecentNAV,*myInfoNav;
}
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (nonatomic, retain) LeftMenuViewController* leftMenuVC;

@end

static ViewController *instance;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    instance = self;
    // Do any additional setup after loading the view, typically from a nib.
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [panGesture delaysTouchesBegan];
    [self.view addGestureRecognizer:panGesture];
    
    self.leftMenuVC = [[LeftMenuViewController alloc] init];
//    [self.leftMenuVC setBgRGB:0x000000];
    [self.leftMenuVC setBaseController:self];
    [self.leftMenuVC setDelegate:self];
    [self.view addSubview:self.leftMenuVC.view];
    self.leftMenuVC.view.frame  = self.view.bounds;
    
    [self autoLogin];
}

//test
- (void)autoLogin
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LoginViewController *loginVC = [story instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.baseController presentViewController:loginVC animated:NO completion:nil];
}

+ (ViewController*)sharedInstance
{
    if (instance==nil) {
        instance = [super init];
    }
    return instance;
}

- (void)showHideLeftMenu
{
    [self showHideLeftMenu:nil];
}

- (void)showHideLeftMenu:(id)sender {
    [self.leftMenuVC showHideSidebar];
}

- (void)panDetected:(UIPanGestureRecognizer*)recoginzer
{
    [self.leftMenuVC panDetected:recoginzer];
}

- (void)toViewControllerAtIndex:(NSInteger)index
{
    NSLog(@"跳转页面");
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    switch (index) {
        case 0:{
            NSLog(@"进入钓点");
            if (fishLocationNAV==nil) {
                fishLocationNAV = [story instantiateViewControllerWithIdentifier:@"FishLocationNAVViewController"];
                [self addChildViewController:fishLocationNAV];
            }
            [self.baseView addSubview:fishLocationNAV.view];
            break;
        }
        case 1:{
            NSLog(@"进入热闹");
            if (SNSNav==nil) {
                SNSNav = [story instantiateViewControllerWithIdentifier:@"SNSNavViewController"];
                [self addChildViewController:SNSNav];
            }
            [self.baseView addSubview:SNSNav.view];
            break;
        }
        case 2:{
            NSLog(@"进入消息");
            if (chatRecentNAV==nil) {
                ChatRecentViewController *CRVC = [[ChatRecentViewController alloc] initWithDisplayConversationTypes:@[@(ConversationType_PRIVATE)] collectionConversationType:nil];
                chatRecentNAV = [[UINavigationController alloc] initWithRootViewController:CRVC];
                [self addChildViewController:chatRecentNAV];
            }
            [self.baseView addSubview:chatRecentNAV.view];
            break;
        }
        case 3:{
            NSLog(@"进入个人");
            if (myInfoNav==nil) {
                myInfoNav = [story instantiateViewControllerWithIdentifier:@"MyInfoNavViewController"];
                [self addChildViewController:myInfoNav];
            }
            [self.baseView addSubview:myInfoNav.view];
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
