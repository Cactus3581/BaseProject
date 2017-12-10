//
//  NSDecimalNumber+CalculatingByString.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

//https://github.com/adi-li/NSDecimalNumber-StringCalculation
#import <Foundation/Foundation.h>

@interface NSDecimalNumber (JKCalculatingByString)
/**
 *
 *   use string calculation for nsdecimalnumber, for simplicity when doing much calculation works. 
 *
 *  @param equation <#equation description#>
 *  @param numbers  <#numbers description#>
 *
 *  @return <#return value description#>
 */
+ (NSDecimalNumber *)_decimalNumberWithEquation:(NSString *)equation decimalNumbers:(NSDictionary *)numbers;
@end
