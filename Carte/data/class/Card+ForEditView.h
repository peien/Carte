//
//  Card+ForEditView.h
//  Carte
//
//  Created by CJK on 13-3-18.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "Card.h"
#import "HZAreaPickerView.h"
#import "KHHData.h"

@interface Card (ForEditView)


- (void)upFieldFromTag:(int)tag value:(NSString *)value;
- (void)upAddressTab:(HZAreaPickerView *)picker reloadRow:(void(^)())reloadRow;

- (void)doInsertParamSection1:(NSString *)str reloadSection:(void(^)())reloadSection;
- (void)doInsertParamSection2:(NSString *)str reloadSection:(void(^)())reloadSection;
- (void)doInsertParamSection3:(NSString *)str reloadSection:(void(^)())reloadSection;
- (void)doDeleteParamSection1:(ParamForEditecard *)paramPro reloadSection:(void(^)())reloadSection;
- (void)doDeleteParamSection2:(ParamForEditecard *)paramPro reloadSection:(void(^)())reloadSection;
- (void)doDeleteParamSection3:(ParamForEditecard *)paramPro reloadSection:(void(^)())reloadSection;

- (void)save;
@end
