//
//  OpenCVWrapper.h
//  Face_Recognition_Project
//
//  Created by Kevin Solano Jimenez on 10/14/20.
//  Copyright © 2020 Kevin Solano Jimenez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject

+ (NSString *) openCVVersionString;
+ (nullable UIImage *) applyModifications: (UIImage *) image;

@end

NS_ASSUME_NONNULL_END
