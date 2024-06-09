import 'package:flutter/material.dart';
import 'package:simple_contact_app/constants/app_dimens.dart';

import 'app_colors.dart';


class AppStyles {
  static const _defaultFontTextStyle = TextStyle();

  static final textField1 = _defaultFontTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    color: AppColors.neutral500,
    fontSize: AppDimens.fontSize7,);

  static final button1 = _defaultFontTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    color: AppColors.neutral500,
    fontSize: AppDimens.fontSize2,
  );

  
  static final buttonTextStyle = _defaultFontTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: AppDimens.fontSize2,
  );

  static final titleStyle = _defaultFontTextStyle.copyWith(
    fontWeight: FontWeight.w800,
    color: AppColors.neutral500,
    fontSize: AppDimens.fontSize5,
  );

  static final avatarTextStyle = _defaultFontTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    color: AppColors.neutral500,
    fontSize: AppDimens.fontSize10,
  );

  static final mediumStyle = _defaultFontTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    color: AppColors.neutral500,
    fontSize: AppDimens.fontSize3,
    height: 1.6,
  );

  static final cardTitleStyle = _defaultFontTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    color: AppColors.neutral500,
    fontSize: AppDimens.fontSize4,
  );

  static final bodyStyle = _defaultFontTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    color: AppColors.neutral500,
    fontSize: AppDimens.fontSize4,
    height: 1.6,
  );

  static final subtitleStyle = _defaultFontTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    color: AppColors.neutral300,
    fontSize: AppDimens.fontSize2,
    height: 1.6,
  );

  static final textFieldHintStyle = _defaultFontTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    color: AppColors.neutral300,
    fontSize: AppDimens.fontSize2,
  );

  static final textFieldInputStyle = _defaultFontTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    color: AppColors.neutral500,
    fontSize: AppDimens.fontSize2,
  );

  static final primaryButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    textStyle: AppStyles.buttonTextStyle,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.margin1)
    ),
    backgroundColor: AppColors.primary,
    surfaceTintColor: AppColors.neutral500,
  );

  static final outlinedButtonStyle = TextButton.styleFrom(
    elevation: 0,
    textStyle: AppStyles.buttonTextStyle,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.margin1),
      side: const BorderSide(
        color: AppColors.primary,
        width: 2.0,
      )
    ),
    backgroundColor: Colors.transparent,
    //surfaceTintColor: AppColors.neutral500,
  );

  static final deleteButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: AppColors.redColor,
    textStyle: AppStyles.buttonTextStyle,
    side: const BorderSide(color: AppColors.redColor)
  );

  static final contactDetailsTitleStyle = _defaultFontTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    color: AppColors.neutral500,
    fontSize: AppDimens.fontSize7,
  );
}