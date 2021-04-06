//
//  DefaultBlock.h
//  TimeClock
//
//  Created by Apple on 2019/12/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#ifndef DefaultBlock_h
#define DefaultBlock_h

typedef void(^backBlock)(id   obj);
typedef void(^selctedBlock)(NSInteger index,id   obj);

typedef void(^clockBlock)(NSDate*date,id obj,NSDateFormatter *formatter);
#endif /* DefaultBlock_h */
