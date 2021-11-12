# flutter_my_page

Flutter project based on GetX

## Directory Structure

```
├── lib //Project code root directory
│   ├── app
│   │   ├── common
│   │   │   └── common.dart
│   │   ├── config
│   │   │   ├── application.dart
│   │   │   └── constants.dart
│   │   ├── data
│   │   ├── lang //Localization
│   │   │   ├── en_US.dart //English
│   │   │   ├── translation_service.dart //Configuration file
│   │   │   └── ja_JP.dart //Japanese
│   │   ├── modules //Each functional module
│   │   │   ├── features
│   │   │   │   ├── bindings
│   │   │   │   │   └── features_binding.dart
│   │   │   │   ├── controllers
│   │   │   │   │   └── features_controller.dart
│   │   │   │   └── views
│   │   │   │       └── features_view.dart
│   │   │   ├── home
│   │   │   │   ├── bindings
│   │   │   │   │   └── home_binding.dart
│   │   │   │   ├── controllers
│   │   │   │   │   └── home_controller.dart
│   │   │   │   ├── models
│   │   │   │   │   ├── test.dart
│   │   │   │   │   ├── test_entity.dart
│   │   │   │   │   └── user_info_entity.dart
│   │   │   │   ├── service
│   │   │   │   │   ├── api.dart
│   │   │   │   │   └── service.dart
│   │   │   │   └── views
│   │   │   │       └── home_page.dart
│   │   │   ├── index
│   │   │   │   ├── bindings
│   │   │   │   │   └── index_binding.dart
│   │   │   │   ├── controllers
│   │   │   │   │   └── index_controller.dart
│   │   │   │   └── views
│   │   │   │       └── index_page.dart
│   │   │   └── mine
│   │   │       ├── bindings
│   │   │       │   ├── change_language_binding.dart
│   │   │       │   ├── change_theme_binding.dart
│   │   │       │   └── mine_binding.dart
│   │   │       ├── controllers
│   │   │       │   ├── change_language_controller.dart
│   │   │       │   ├── change_theme_controller.dart
│   │   │       │   └── mine_controller.dart
│   │   │       ├── models
│   │   │       └── views
│   │   │           ├── change_language_page.dart
│   │   │           ├── change_theme_page.dart
│   │   │           └── mine_page.dart
│   │   ├── plugins
│   │   │   ├── options
│   │   │   │   ├── options.dart
│   │   │   │   ├── scales.dart //Screen adaptation
│   │   │   │   └── themes.dart //Theme configuration
│   │   │   └── other
│   │   │       └── eventbus //Global notification
│   │   ├── resource
│   │   │   ├── dimens.dart //Fit size
│   │   │   └── resource_colors.dart //Common colors
│   │   ├── routes
│   │   │   ├── 404.dart //404 page
│   │   │   ├── app_routes.dart //Routing configuration
│   │   │   ├── feature_routes.dart //Submodule routing
│   │   │   ├── home_route.dart //Submodule routing
│   │   │   ├── mine_route.dart //Submodule routing
│   │   │   └── utils
│   │   │       └── get_navigator.dart //Route jump
│   │   ├── utils
│   │   │   ├── extensions
│   │   │   │   ├── extension_color.dart //Color class extension
│   │   │   │   └── extension_text.dart //Text class extension
│   │   │   ├── keep_alive_page.dart //Page keep-alive function
│   │   │   ├── log
│   │   │   │   └── log.dart //Log print
│   │   │   ├── network  //Network request related
│   │   │   │   ├── async_task.dart
│   │   │   │   ├── dio
│   │   │   │   │   ├── call_setting.dart
│   │   │   │   │   ├── callback.dart
│   │   │   │   │   ├── dio_creator.dart
│   │   │   │   │   ├── dio_provider.dart
│   │   │   │   │   ├── executor.dart
│   │   │   │   │   ├── result_entity.dart
│   │   │   │   │   ├── state.dart
│   │   │   │   │   └── transformer.dart
│   │   │   │   ├── http_util.dart
│   │   │   │   ├── http_utils.dart
│   │   │   │   ├── inteceptor
│   │   │   │   │   ├── log_inteceptor.dart
│   │   │   │   │   └── sign_interceptor.dart
│   │   │   │   ├── network.dart
│   │   │   │   └── task_type.dart
│   │   │   ├── object_util.dart
│   │   │   ├── sp_utils //GetStorage Data persistence
│   │   │   │   └── sp_utils.dart
│   │   │   └── toast
│   │   │       └── toast.dart
│   │   └── widget
│   │       ├── custom_type.dart
│   │       ├── image_widget.dart
│   │       └── state
│   │           ├── empty_widget.dart
│   │           └── state_widget.dart
│   ├── gen_a //Use the FlutterAddImage plug-in to configure the image resource Path
│   │   └── A.dart
│   ├── generated //JsonToDartBeanAction plug-in to generate Bean class model
│   │   └── json
│   │       ├── base
│   │       │   ├── json_convert_content.dart
│   │       │   └── json_field.dart
│   │       ├── test_entity_helper.dart
│   │       └── user_info_entity_helper.dart
│   ├── generated_plugin_registrant.dart
│   └── main.dart //Project entry file
```
