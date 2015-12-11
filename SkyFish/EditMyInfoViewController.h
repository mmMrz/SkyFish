//
//  EditMyInfoViewController.h
//  SkyFish
//
//  Created by 张燕枭 on 15/12/2.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditMyInfoViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    __weak IBOutlet UIImageView *_headView;
    __weak IBOutlet UITextField *_nikeName;
    __weak IBOutlet UITextField *_region;
    __weak IBOutlet UITextField *_fishAge;
    __weak IBOutlet UITextField *_skill;
    __weak IBOutlet UITextView *_sign;
    
    __weak IBOutlet UIButton *_sexBoy;
    __weak IBOutlet UIButton *_sexGirl;
}

@end
