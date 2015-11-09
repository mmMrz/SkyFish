//
//  CSLoadData.m
//  CQSQ
//
//  Created by linan on 15-2-4.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "CSLoadData.h"
#import "AFNetworking.h"

@implementation CSLoadData

//GET请求
+(void)requestOfInfomationWithURI:(NSString *)URI
                         complete:(void (^)(NSDictionary *responseDic))complete failed:(void (^)(NSError *error))failed
{
    NSString *strURL;
    if ([URI hasPrefix:@"http://"]) {
        strURL = [NSString stringWithFormat:@"%@",URI];
    }else{
        strURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,URI];
    }
    NSLog(@"GET请求%@",strURL);
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    [manage GET:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (complete) {
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failed) {
            failed(error);
        }
    }];

}

//POST请求
+(void)requestOfInfomationWithURI:(NSString *)URI
                    andParameters:(id)theParameters
                         complete:(void (^)(NSDictionary *responseDic))complete failed:(void (^)(NSError *error))failed
{
    NSString *strURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,URI];
    NSLog(@"POST请求%@",strURL);
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    if ([GlobalData sharedInstance].currentUserInfo.token!=nil) {
        [manage.requestSerializer setValue:[GlobalData sharedInstance].currentUserInfo.token forHTTPHeaderField:@"token"];
        [manage.requestSerializer setValue:[GlobalData sharedInstance].currentUserInfo.uid forHTTPHeaderField:@"uid"];
    }
    [manage POST:strURL parameters:theParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (complete) {
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

+ (void)requestGifHeaderWithURI:(NSString *)URI
                         complete:(void (^)(NSData *responseData))complete failed:(void (^)(NSError *error))failed
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage.requestSerializer setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    
    [manage GET:URI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (complete) {
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

+ (void)requestJpgHeaderWithURI:(NSString *)URI
                       complete:(void (^)(NSData *responseData))complete failed:(void (^)(NSError *error))failed
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage.requestSerializer setValue:@"bytes0-209" forHTTPHeaderField:@"Range"];
    
    [manage GET:URI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (complete) {
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

//上传文件
+(void)requestOfInfomationWithURI:(NSString *)URI
                      andFilePath:(NSString*)theFilePath
                 andFileParamName:(NSString*)theFileParamName
                      andFileName:(NSString*)theFileName
                  andFileMimeType:(NSString*)theFileMimeType
                    andParameters:(NSDictionary*)theParameters
                         complete:(void (^)(NSDictionary *responseDic))complete failed:(void (^)(NSError *error))failed
{
    NSString *strURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,URI];
    NSLog(@"上传文件:%@",strURL);
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    [manage POST:strURL parameters:theParameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = [NSData dataWithContentsOfFile:theFilePath];
        [formData appendPartWithFileData:data name:theFileParamName fileName:theFileName mimeType:theFileMimeType];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (complete) {
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
    
}

@end
