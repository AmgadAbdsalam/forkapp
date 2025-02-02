import 'package:flutter/material.dart';
import 'package:responsive/presntation/resources/color_manager.dart';
import 'package:responsive/presntation/resources/strings_manager.dart';
import 'package:responsive/presntation/resources/values_manager.dart';

class SettingSelection extends StatelessWidget {
  const SettingSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .05,
          ),
          Text(
            AppStrings.setting,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.language,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 50,
                child: DropdownButton(
                  
                  menuWidth: MediaQuery.sizeOf(context).width * .8,
                  icon: Container(
                    height: double.infinity,
                    width: 40,
                    color: ColorManager.primary,
                    child: Icon(
                      color: ColorManager.white,
                      Icons.keyboard_arrow_down_sharp,
                    ),
                  ),
                  value: 1,
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Padding(
                        padding: EdgeInsets.all(AppSize.s8),
                        child: Text('English'),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Padding(
                        padding: EdgeInsets.all(AppSize.s8),
                        child: Text('Arabic'),
                      ),
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.darkTheme,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Switch(
                value: true,
                onChanged: (value) {},
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.showNotifications,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Switch(
                value: false,
                onChanged: (value) {},
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.sounds,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Switch(
                value: true,
                onChanged: (value) {},
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.vibrations,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Switch(
                value: true,
                onChanged: (value) {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
