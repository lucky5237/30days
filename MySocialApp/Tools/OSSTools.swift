//
//  OSSTools.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/17.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import AliyunOSSiOS
import SwiftDate
import SVProgressHUD


class OSSTools {

    static func uploadImage(image:UIImage,completion:(()->Void)?){
        
        let request = OSSPutObjectRequest()
        request.uploadingData = image.pngData()!
        request.bucketName = OSS_BUCKET_PRIVATE
        request.objectKey = "landscape-painting.jpg"
        request.uploadProgress = { (bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
//            print("bytesSent:\(bytesSent),totalBytesSent:\(totalBytesSent),totalBytesExpectedToSend:\(totalBytesExpectedToSend)");
        };
        
        let task = kAliyunOssClient.putObject(request)
        task.continue(successBlock: { task -> Any? in
            if let error = task.error{
                showErrorText("图片上传失败")
                print("图片上传失败 ：%@",error)
                return nil
            }
            
            if let successCallback = completion{
                print("图片上传成功 ：%@",request.objectKey)
                successCallback()
            }
            return nil
        })
    }
}
