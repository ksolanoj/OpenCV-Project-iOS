//
//  OpenCVWrapper.mm
//  Face_Recognition_Project
//
//  Created by Kevin Solano Jimenez on 10/14/20.
//  Copyright © 2020 Kevin Solano Jimenez. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import <iostream>
#import <UIKit/UIKit.h>
#import "OpenCVWrapper.h"

@implementation OpenCVWrapper


+ (NSString *) openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
    
}

+ (nullable UIImage *) applyModifications: (UIImage *) image {
    // Obtener App Bundle
    NSBundle * appBundle = [NSBundle mainBundle];
    
    // Leer es Cascade
    cv::CascadeClassifier face_cascade;
    NSString * face_cascade_name = @"haarcascade_frontalface_default";
    NSString * face_cascade_extension = @"xml";
    NSString * cascadePathInBundle = [appBundle pathForResource:face_cascade_name ofType:face_cascade_extension];
    std::string cascadePath([cascadePathInBundle UTF8String]);
    
    // Se verifica si se carga el Cascade
    if (face_cascade.load(cascadePath)) {
        // Convertimos la imagen a un arreglo Mat en Blanco y negro
        cv::Mat imageMatArray;
        cv::Mat grey_image;
        UIImageToMat(image, imageMatArray);
        if(imageMatArray.channels() != 1) {
            cv::cvtColor(imageMatArray, grey_image, cv::COLOR_BGR2GRAY);
            cv::equalizeHist(grey_image, grey_image);
        } else {
            grey_image = imageMatArray;
        }
        // Detección de Caras
        std::vector<cv::Rect> faces;
        face_cascade.detectMultiScale(grey_image, faces);
        cv::Mat finalFace;
        for (int i = 0;  i < faces.size(); i++) {
            imageMatArray(faces[i]).copyTo(finalFace);
        }
        return MatToUIImage(finalFace);
        
    } else {
        printf("Load Error");
    }
    return nil;
}

@end
