//
//  EditMyInfoViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/12/2.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "EditMyInfoViewController.h"
#import <QiniuSDK.h>

@interface EditMyInfoViewController(){
    
    NSString *imageName;
}

@end

@implementation EditMyInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"发表评论"];
    [self.navigationItem addRightBarButtonItem:[UIBarButtonItem themedBarButtonWithTarget:self andSelector:@selector(done:) andButtonTitle:@"完成"]];
    [self setupView];
}

- (void)setupView
{
    NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[GlobalData sharedInstance].currentUserInfo.avatar, nil, nil, kCFStringEncodingUTF8));
    UIImage *image = [UIImage imageNamed:@"未登录头像"];
    [_headView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
        [[GlobalData sharedInstance].currentUserInfo setAvatarImg:image];
    }];
    if ([GlobalData sharedInstance].currentUserInfo.gender.integerValue==1) {
        [_sexBoy setSelected:YES];
        [_sexGirl setSelected:NO];
    }else if ([GlobalData sharedInstance].currentUserInfo.gender.integerValue==2) {
        [_sexBoy setSelected:NO];
        [_sexGirl setSelected:YES];
    }
    [_nikeName setText:[GlobalData sharedInstance].currentUserInfo.name];
    [_region setText:[GlobalData sharedInstance].currentUserInfo.address];
    [_fishAge setText:[GlobalData sharedInstance].currentUserInfo.age];
    [_skill setText:[GlobalData sharedInstance].currentUserInfo.skill];
    [_sign setText:[GlobalData sharedInstance].currentUserInfo.sign];
}

- (void)done:(UIButton*)sender
{
//    avatar	string	是
//    name	string	是
//    gender	int	是	0保密 1男 2女
//    address	string	是
//    age	int	是	钓龄
//    skill	string	是	擅长
//    sign	string	是	签名
    
    
    [self updateHeadToQINIU:_headView.image];
    
    
}

- (void)updateInfoWithImageQINIUKey:(NSString *)headQINIUKey
{
    [ProgressHUD show:@"修改资料中"];
    //完成修改，保存到服务器
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[NSString stringWithFormat:@"%@%@",QINIU_IMGURL,headQINIUKey] forKey:@"avatar"];
    [parameters setObject:[GlobalData sharedInstance].currentUserInfo.name forKey:@"name"];
    [parameters setObject:[GlobalData sharedInstance].currentUserInfo.gender forKey:@"gender"];
    [parameters setObject:[GlobalData sharedInstance].currentUserInfo.address forKey:@"address"];
    [parameters setObject:[GlobalData sharedInstance].currentUserInfo.age forKey:@"age"];
    [parameters setObject:[GlobalData sharedInstance].currentUserInfo.skill forKey:@"skill"];
    [parameters setObject:[GlobalData sharedInstance].currentUserInfo.sign forKey:@"sign"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",USER_MODINFO] andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue]==0) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showError:responseDic[@"info"]];
        }
        [ProgressHUD showError:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
        [ProgressHUD showError:@"修改失败"];
    }];
}

- (IBAction)changeHead:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"图库", nil];
    [actionSheet showInView:self.view];
}

- (void)updateHeadToQINIU:(UIImage*)image
{
    [ProgressHUD show:@"上传头像中"];
//    NSString *token = [GlobalData sharedInstance].currentUserInfo.qiniuToken;
//    QNUploadManager *upManager = [[QNUploadManager alloc] init];
//    NSData *data = UIImageJPEGRepresentation(image, 1.0);
//    [upManager putData:data key:imageName token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//        if (resp==nil) {
//            [ProgressHUD showError:@"上传失败"];
//        }else{
//            [self updateInfoWithImageQINIUKey:key];
//        }
//    } option:nil];
    
    
    NSString *token = [GlobalData sharedInstance].currentUserInfo.qiniuToken;
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [upManager putData:data key:imageNameKey token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (resp==nil) {
            [imageInfo setObject:@"-1" forKey:@"progress"];
        }else{
            [imageInfo setObject:@"1" forKey:@"progress"];
            [imageInfo setObject:imageNameKey forKey:@"key"];
            if (shouldPublish) {
                [self sendDynamic:nil];
            }
        }
    } option:nil];
}

- (IBAction)chageSex:(UIButton *)sender {
    if (sender==_sexBoy) {
        [_sexBoy setSelected:YES];
        [_sexGirl setSelected:NO];
        [[GlobalData sharedInstance].currentUserInfo setGender:@"1"];
    }else if (sender==_sexGirl) {
        [_sexBoy setSelected:NO];
        [_sexGirl setSelected:YES];
        [[GlobalData sharedInstance].currentUserInfo setGender:@"2"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==_nikeName) {
        [[GlobalData sharedInstance].currentUserInfo setName:textField.text];
    }else if (textField==_region) {
        [[GlobalData sharedInstance].currentUserInfo setAddress:textField.text];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [[GlobalData sharedInstance].currentUserInfo setSign:textView.text];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [[GlobalData sharedInstance].currentUserInfo setSign:textView.text];
        return NO;
    }
    return YES;
}

- (IBAction)changeFishAge:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择钓龄" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"3年以下",@"3-5年",@"5-10年",@"10年以上", nil];
    [actionSheet setTag:1];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==0) {
        switch (buttonIndex) {
            case 0:{
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
                [imagePickerController setAllowsEditing:YES];
                [imagePickerController setDelegate:self];
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
                break;
                
            case 1:{
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                [imagePickerController setAllowsEditing:YES];
                [imagePickerController setDelegate:self];
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    }else if (actionSheet.tag==1) {
        switch (buttonIndex) {
            case 0:
                [[GlobalData sharedInstance].currentUserInfo setAge:@"3年以下"];
                [_fishAge setText:@"3年以下"];
                break;
                
            case 1:
                [[GlobalData sharedInstance].currentUserInfo setAge:@"3-5年"];
                [_fishAge setText:@"3-5年"];
                break;
                
            case 2:
                [[GlobalData sharedInstance].currentUserInfo setAge:@"5-10年"];
                [_fishAge setText:@"5-10年"];
                break;
                
            case 3:
                [[GlobalData sharedInstance].currentUserInfo setAge:@"10年以上"];
                [_fishAge setText:@"10年以上"];
                break;
                
            default:
                break;
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    imageName = [(NSURL*)info[@"UIImagePickerControllerReferenceURL"] parameterDictionary][@"id"];
    [self updateHeadToQINIU:info[@"UIImagePickerControllerEditedImage"]];
    [_headView setImage:info[@"UIImagePickerControllerEditedImage"]];
}

@end
