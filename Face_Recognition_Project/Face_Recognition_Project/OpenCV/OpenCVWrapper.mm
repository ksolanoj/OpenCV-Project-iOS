//
//  OpenCVWrapper.mm
//  Face_Recognition_Project
//
//  Created by Kevin Solano Jimenez on 10/14/20.
//  Copyright © 2020 Kevin Solano Jimenez. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import "OpenCVWrapper.h"

@implementation OpenCVWrapper


+ (NSString *) openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}

@end