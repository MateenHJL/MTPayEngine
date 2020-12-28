//
//  HttpMacro.h
//  MTTemplate
//
//  Created by Mateen on 2017/1/16.
//  Copyright © 2017年 Teen ma. All rights reserved.
//

#define kHTTPStatusCodeNoneError 1 
#define kHTTPStatusCodeTokenRedefine 2//被T

typedef NS_ENUM (NSInteger,HTTPMethod)
{
    HTTPMethodPOST,  //the way you accessed to server is POST.
    HTTPMethodGET,   //the way you accessed to server is GET.
    HTTPMethodPUT,   //the way you accessed to server is PUT
    HTTPMethodDELETE //the way you accessed to server is Delete
};

typedef NS_ENUM(NSInteger , HTTPCacheType) {
    HTTPCacheTypeServerOnly,             //just returned the response data after request from Server.the data didn't save.and not read the data which in sandbox as the same time.
    HTTPCacheTypeCacheOnly,              //just returned the local data which in sandbox,it didn't request from Server.it will request the server to get real response data if the data isn't existing.the data which is gotten from server will be save at sandbox.
    HTTPCacheTypeCacheDataThenServerData //the first,you will get local data which is in sandbox,and then you will get the real response data which is gotten from Server.the data which is gotten from server will be save at sandbox.
};

typedef NS_ENUM(NSInteger , HTTPStatusCode) {
    HTTPStatusCodeDetaultCode                 = 0,//the connection didn't begun yet.
    HTTPStatusCodeNoneError                   = kHTTPStatusCodeNoneError,//none error,default it is.
    HTTPStatusCodeTokenRedefine               = kHTTPStatusCodeTokenRedefine,//the account is logout by another device.need logout.
    HTTPStatusCodeRequestUrlIsNilOrNotCorrect = 699999,//the url of httpItem is nil or empty string url.
    HTTPStatusCodeParseError                  = 700000,//the the format of response which be gotten from Server is not correct.parse error.
    HTTPStatusCodeResponseDataIsNil           = 700001,//the response data from Server is nil.
    HTTPStatusCodeConnectedFailed             = 700002,//the connection between server and client is not suitable to using.
    HTTPStatusCodeNoNetwork                   = 700003,//the connection of this device can't be reached.because of no network now.
    HTTPStatusCodePostFileIsNil               = 700004,//the file you post to server is nil.
    HTTPStatusCodePostFileKeyIsNull           = 700005,//the key matched the file you post to server is null
    HTTPStatusCodeNoConfigFile                = 700006,//there's no httpConfig file yet,user should call - (void)setupHttpEngineWithConfig first
};

typedef NS_ENUM(NSInteger , HTTPRequestStatus) {
    HTTPRequestStatusPrepared,  //the request of httpItem is wating for request.
    HTTPRequestIsConnecting,    //the request of httpItem is connecting.
    HTTPRequestStatusHasFinished//the request of httpItem has already been finished.
};

typedef NS_ENUM(NSInteger , HTTPRequestType) {
    HTTPRequestTypeRequestJsonDataType,//normal http request,send data to server,then get the jsonString from server.
    HTTPRequestTypeDownloadFilesType,  //download some files or pictures.
    HTTPRequestTypeUploadFilesType     //upload some files or pictures.
};

typedef NS_ENUM(NSInteger , HTTPResponseDataType) {
    HTTPResponseDataTypeUnknownType,         //the response didn't loaded yet,default it is.
    HTTPResponseDataTypeLoadedFromServer,    //the response which loaded from Server
    HTTPResponseDataTypeLoadedFromLocalCache, //the response which loaded from local files or memories.
    HTTPResponseDataTypeLoadedFromMockingResponse//the response loaded from local data which mocked by developer
};

typedef NS_ENUM(NSInteger , HTTPConnectionCompletedStatus){
    HTTPConnectionCompletedStatusUnknowStatus,                              //didn't request server at all.
    HTTPConnectionCompletedStatusConnectedSuccessed,                        //your connection is completed and the response you got from server is correct.
    HTTPConnectionCompletedStatusConnectedException,                        //your connection is completed ,but the response you got from server is not correct.
    HTTPConnectionCompletedStatusConnectedFailed                            //your connection is failed.because of none network or request time out.
};

typedef NS_ENUM(NSInteger , HTTPRepeatActionType) {
    HTTPRepeatActionTypeNone,              //didn't do anything yet.
    HTTPRepeatActionTypeUploading,         //you are receiving the data while you uploaded.
    HTTPRepeatActionTypeDownloading,       //you are receiving the data while you downloaded.
};

typedef NS_ENUM(NSInteger , HTTPRequestResultType) {
    HTTPRequestResultTypeSuccessed,        //http request successed.
    HTTPRequestResultTypeFailed,           //http request failed,maybe your code or result is not match
    HTTPRequestResultTypeAnotherType,      //http request will be determinal
};

#define HTTPWAYPOST   @"POST"
#define HTTPWAYGET    @"GET"
#define HTTPWAYDELETE @"DELETE"
#define HTTPWAYPUT    @"PUT"

