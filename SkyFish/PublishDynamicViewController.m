//
//  PublishDynamicViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/26.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "PublishDynamicViewController.h"
#import "ImageCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "DNAsset.h"
#import "NSURL+DNIMagePickerUrlEqual.h"
#import "DNImagePickerController.h"
#import <QiniuSDK.h>

@interface PublishDynamicViewController ()<DNImagePickerControllerDelegate>{
    NSMutableDictionary *_imageDic;
    
    BOOL shouldPublish,isFullImage;
}

@end

@implementation PublishDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController loadTheme];
    [self setTitle:@"发表渔获"];
    [self.navigationItem addRightBarButtonItem:[UIBarButtonItem themedCancelButtonWithTarget:self andSelector:@selector(close:)]];
    
    _imageDic = [[NSMutableDictionary alloc] init];
    
    if ([GlobalData sharedInstance].currentUserInfo.qiniuToken==nil||[[GlobalData sharedInstance].currentUserInfo.qiniuToken isEqualToString:@""]) {
        [self requestQINIUToken];
    }
}

- (void)close:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendDynamic:(UIButton *)sender {
    //检查图片都传完了没有
    shouldPublish = YES;
    NSMutableArray *shouldPublishImageUrl = [[NSMutableArray alloc] initWithCapacity:_imageDic.allKeys.count];
    for (NSString *imageNameKey in _imageDic.allKeys) {
        NSMutableDictionary *imageInfo = _imageDic[imageNameKey];
        NSString *imgKey = [imageInfo objectForKey:@"key"];
        if (imgKey==nil) {
            return;
        }
        //把图片URL整理好，变成JSON字符串
        [shouldPublishImageUrl addObject:[NSString stringWithFormat:@"%@%@",QINIU_IMGURL,imageNameKey]];
    }
    [ProgressHUD show:@"发表中"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:text_content.text forKey:@"content"];
    [parameters setObject:[shouldPublishImageUrl JSONString] forKey:@"images"];
    [parameters setObject:@"" forKey:@"address"];
    [parameters setObject:@"" forKey:@"lng"];
    [parameters setObject:@"" forKey:@"lat"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",WEIBO_ADD] andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue] == 0) {
            [ProgressHUD dismiss];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [ProgressHUD showSuccess:responseDic[@"info"]];
        }
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"说点什么吧"]) {
        [textView setText:@""];
        [textView setTextColor:[UIColor blackColor]];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([[textView.text trimSpace] isEqualToString:@""]) {
        [textView setText:@"说点什么吧"];
        [textView setTextColor:[UIColor blackColor]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addImage:(UIButton*)sender
{
    DNImagePickerController *imagePicker = [[DNImagePickerController alloc] init];
    imagePicker.imagePickerDelegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_imageDic allKeys].count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==[_imageDic allKeys].count) {
        static NSString *ImageCollectionAddCellIdentifier = @"ImageCollectionAddCellIdentifier";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCollectionAddCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    
    static NSString *ImageCollectionViewCellIdentifier = @"ImageCollectionViewCellIdentifier";
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCollectionViewCellIdentifier forIndexPath:indexPath];
    [cell.delBtn setTag:indexPath.row];
    [cell.delBtn addTarget:self action:@selector(delImage:) forControlEvents:UIControlEventTouchUpInside];
    
    DNAsset *dnasset = _imageDic[[_imageDic allKeys][indexPath.row]][@"asset"];
    
    ALAssetsLibrary *lib = [ALAssetsLibrary new];
    __block ImageCollectionViewCell *blockCell = cell;
    __weak typeof(self) weakSelf = self;
    [lib assetForURL:dnasset.url resultBlock:^(ALAsset *asset){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (asset) {
            [strongSelf setCell:blockCell asset:asset];
        } else {
            // On iOS 8.1 [library assetForUrl] Photo Streams always returns nil. Try to obtain it in an alternative way
            [lib enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
                               usingBlock:^(ALAssetsGroup *group, BOOL *stop)
             {
                 [group enumerateAssetsWithOptions:NSEnumerationReverse
                                        usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                            
                                            if([[result valueForProperty:ALAssetPropertyAssetURL] isEqual:dnasset.url])
                                            {
                                                [strongSelf setCell:blockCell asset:result];
                                                *stop = YES;
                                            }
                                        }];
             }
                             failureBlock:^(NSError *error)
             {
                 [strongSelf setCell:blockCell asset:nil];
             }];
        }
        
    } failureBlock:^(NSError *error){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf setCell:blockCell asset:nil];
    }];
    
    
    return cell;
}

- (void)setCell:(ImageCollectionViewCell *)cell asset:(ALAsset *)asset
{
    
    if (!asset) {
        cell.imageView.image = [UIImage imageNamed:@"assets_placeholder_picture"];
        return;
    }
    
    UIImage *image;
    if (isFullImage) {
        NSNumber *orientationValue = [asset valueForProperty:ALAssetPropertyOrientation];
        UIImageOrientation orientation = UIImageOrientationUp;
        if (orientationValue != nil) {
            orientation = [orientationValue intValue];
        }
        
        image = [UIImage imageWithCGImage:asset.thumbnail];
        //        image = [UIImage imageWithCGImage:asset.thumbnail scale:0.1 orientation:orientation];
        
        
    } else {
        image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
    }
    
    cell.imageView.image = image;
    [cell.imageView setContentMode:UIViewContentModeScaleAspectFill];
}

#define kSizeThumbnailCollectionView  self.view.frame.size.width/2

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 70);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

#pragma mark - DNImagePickerControllerDelegate

- (void)dnImagePickerController:(DNImagePickerController *)imagePickerController sendImages:(NSArray *)imageAssets isFullImage:(BOOL)fullImage
{
    isFullImage = fullImage;
    NSMutableArray *selectedImgUrl = [[NSMutableArray alloc] initWithCapacity:imageAssets.count];
    [_imageDic removeAllObjects];
    for (DNAsset *imgset in imageAssets) {
        [selectedImgUrl addObject:[imgset.url parameterDictionary][@"id"]];
        if (![[_imageDic allKeys] containsObject:[imgset.url parameterDictionary][@"id"]]) {
            NSMutableDictionary *imageInfo = [[NSMutableDictionary alloc] initWithCapacity:3];
            [imageInfo setObject:imgset forKey:@"asset"];
            [imageInfo setObject:@"-1" forKey:@"progress"];
            [_imageDic setObject:imageInfo forKey:[imgset.url parameterDictionary][@"id"]];
        }
    }
    
    for (NSString *imageNameKey in _imageDic.allKeys) {
        if (![selectedImgUrl containsObject:imageNameKey]) {
            [_imageDic removeObjectForKey:imageNameKey];
        }
    }
    
    [imageCollectionView reloadData];
    
    for (NSLayoutConstraint *constraint in imageCollectionView.constraints) {
        if (constraint.firstItem==imageCollectionView||constraint.firstAttribute==NSLayoutAttributeHeight) {
            //            [imageCollectionView removeConstraint:constraint];
            constraint.constant = ceilf(imageAssets.count/4.0)*75;
        }
    }
    
    [self uploadImageAry];
}

- (void)dnImagePickerControllerDidCancel:(DNImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{}];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        [textView setTextColor:[UIColor lightGrayColor]];
        [textView setText:@"说点什么吧"];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - 上传图片到七牛
- (void)uploadImageAry
{
    if ([GlobalData sharedInstance].currentUserInfo.qiniuToken==nil||[[GlobalData sharedInstance].currentUserInfo.qiniuToken isEqualToString:@""]) {
        [self requestQINIUToken];
        return;
    }
    for (NSString *imageNameKey in _imageDic.allKeys) {
        NSMutableDictionary *imageInfo = _imageDic[imageNameKey];
        float progress = [imageInfo[@"progress"] floatValue];
        if (progress==-1) {
            DNAsset *dnasset = imageInfo[@"asset"];
            ALAssetsLibrary *lib = [ALAssetsLibrary new];
            [lib assetForURL:dnasset.url resultBlock:^(ALAsset *asset){
                if (asset) {
                    UIImage *image;
                    if (isFullImage) {
                        NSNumber *orientationValue = [asset valueForProperty:ALAssetPropertyOrientation];
                        UIImageOrientation orientation = UIImageOrientationUp;
                        if (orientationValue != nil) {
                            orientation = [orientationValue intValue];
                        }
                        image = [UIImage imageWithCGImage:asset.thumbnail];
                        //        image = [UIImage imageWithCGImage:asset.thumbnail scale:0.1 orientation:orientation];
                    } else {
                        image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                    }
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
                } else {
                    // On iOS 8.1 [library assetForUrl] Photo Streams always returns nil. Try to obtain it in an alternative way
                    [lib enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
                                       usingBlock:^(ALAssetsGroup *group, BOOL *stop){
                                           [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                               if([[result valueForProperty:ALAssetPropertyAssetURL] isEqual:dnasset.url]) {
                                                   UIImage *image;
                                                   if (isFullImage) {
                                                       NSNumber *orientationValue = [asset valueForProperty:ALAssetPropertyOrientation];
                                                       UIImageOrientation orientation = UIImageOrientationUp;
                                                       if (orientationValue != nil) {
                                                           orientation = [orientationValue intValue];
                                                       }
                                                       image = [UIImage imageWithCGImage:asset.thumbnail];
                                                       //        image = [UIImage imageWithCGImage:asset.thumbnail scale:0.1 orientation:orientation];
                                                   } else {
                                                       image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                                                   }
                                                   *stop = YES;
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
                                           }];
                                       }failureBlock:^(NSError *error){}];
                }
            } failureBlock:^(NSError *error){}];
        }
    }
}

- (void)requestQINIUToken
{
    [CSLoadData requestOfInfomationWithURI:COMMON_QINIUTOKEN andParameters:nil complete:^(NSDictionary *responseDic) {
        if ([CheckData isEmpty:responseDic[@"msg"]]) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showSuccess:responseDic[@"msg"]];
        }
        NSString *qiniuToken = responseDic[@"data"][@"token"];
        [[GlobalData sharedInstance].currentUserInfo setQiniuToken:qiniuToken];
        [self uploadImageAry];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

- (void)delImage:(UIButton*)sender
{
    [_imageDic removeObjectForKey:_imageDic.allKeys[sender.tag]];
    [imageCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]]];
}

@end
