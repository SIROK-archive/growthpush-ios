//
//  GPAppDelegateWrapper.h
//  pickaxe
//
//  Created by Kataoka Naoyuki on 2013/07/14.
//  Copyright (c) 2013年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPAppDelegateWrapperDelegate.h"

@interface GPAppDelegateWrapper : UIResponder <UIApplicationDelegate> {

    id <GPAppDelegateWrapperDelegate> delegate;

}

@property (nonatomic, assign) id <GPAppDelegateWrapperDelegate> delegate;

- (void)setOriginalAppDelegate:(UIResponder <UIApplicationDelegate> *)newOriginalAppDelegate;

@end
