//
//  AddCommentForFishLocationViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/11.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "AddCommentForFishLocationViewController.h"
#import "ImageCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "DNAsset.h"
#import "NSURL+DNIMagePickerUrlEqual.h"
#import "DNImagePickerController.h"

@interface AddCommentForFishLocationViewController ()<DNImagePickerControllerDelegate>{
    __weak IBOutlet UIView *grade_view;
    __weak IBOutlet UIView *grade_baseView;
    __weak IBOutlet UITextView *content_tv;
    __weak IBOutlet UICollectionView *imageCollectionView;
    NSArray *_imageArray;
    
    BOOL isFullImage;
    
    NSMutableArray *_assetsArray;
}

@end

@implementation AddCommentForFishLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController loadTheme];
    [self.navigationItem addTitleViewWithTitle:@"发表评论"];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gradePan:)];
    [grade_baseView addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gradePan:)];
    [grade_baseView addGestureRecognizer:panGesture];
}

- (IBAction)publish:(UIButton *)sender {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:_fishLocationInfo[@"id"] forKey:@"pid"];
    [parameters setObject:content_tv.text forKey:@"content"];
    [parameters setObject:@"" forKey:@"images"];
    [parameters setObject:@"5" forKey:@"score"];
    [CSLoadData requestOfInfomationWithURI:PLACE_SCORE andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([CheckData isEmpty:responseDic[@"msg"]]) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showSuccess:responseDic[@"msg"]];
        }
        NSLog(@"%@",responseDic);
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

- (IBAction)addImage:(UIButton*)sender
{
    DNImagePickerController *imagePicker = [[DNImagePickerController alloc] init];
    imagePicker.imagePickerDelegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==_imageArray.count) {
        static NSString *ImageCollectionAddCellIdentifier = @"ImageCollectionAddCellIdentifier";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCollectionAddCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    
    static NSString *ImageCollectionViewCellIdentifier = @"ImageCollectionViewCellIdentifier";
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCollectionViewCellIdentifier forIndexPath:indexPath];
    
    DNAsset *dnasset = _imageArray[indexPath.row];
    
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
    _assetsArray = [NSMutableArray arrayWithArray:imageAssets];
    isFullImage = fullImage;
    _imageArray = imageAssets;
    [imageCollectionView reloadData];
    
    for (NSLayoutConstraint *constraint in imageCollectionView.constraints) {
        if (constraint.firstItem==imageCollectionView||constraint.firstAttribute==NSLayoutAttributeHeight) {
//            [imageCollectionView removeConstraint:constraint];
            constraint.constant = ceilf(imageAssets.count/4.0)*75;
        }
    }
}

- (void)dnImagePickerControllerDidCancel:(DNImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{}];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"说点什么吧"]) {
        [textView setText:@""];
        [textView setTextColor:[UIColor blackColor]];
    }
    return YES;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)gradePan:(UIPanGestureRecognizer *)recoginzer
{
    CGPoint touchPoint = [recoginzer locationInView:grade_baseView];
    
    float gradeViewWidth = touchPoint.x-grade_view.origin.x;
    
    if (gradeViewWidth<0) {
        gradeViewWidth = 0;
    }else if(gradeViewWidth>140){
        gradeViewWidth = 140;
    }
    [grade_view setWidth:gradeViewWidth];
    
}

@end
