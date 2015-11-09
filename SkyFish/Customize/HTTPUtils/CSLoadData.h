//
//  CSLoadData.h
//  CQSQ
//
//  Created by linan on 15-2-4.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSLoadData : NSObject

//GET请求
//+(void)requestOfInfomationWithURI:(NSString *)URI
//                         complete:(void (^)(NSDictionary *responseDic))complete failed:(void (^)(NSError *error))failed;

//POST请求
+(void)requestOfInfomationWithURI:(NSString *)URI
                    andParameters:(id)theParameters
                         complete:(void (^)(NSDictionary *responseDic))complete failed:(void (^)(NSError *error))failed;

+ (void)requestGifHeaderWithURI:(NSString *)URI
                       complete:(void (^)(NSData *responseData))complete failed:(void (^)(NSError *error))failed;
+ (void)requestJpgHeaderWithURI:(NSString *)URI
                       complete:(void (^)(NSData *responseData))complete failed:(void (^)(NSError *error))failed;
//上传文件
+(void)requestOfInfomationWithURI:(NSString *)URI
                      andFilePath:(NSString*)theFilePath
                 andFileParamName:(NSString*)theFileParamName
                      andFileName:(NSString*)theFileName
                  andFileMimeType:(NSString*)theFileMimeType
                    andParameters:(NSDictionary*)theParameters
                         complete:(void (^)(NSDictionary *responseDic))complete failed:(void (^)(NSError *error))failed;

@end
