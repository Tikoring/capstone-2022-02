import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sports_matching/data/user_model.dart';
import 'package:sports_matching/screens/chat/chatroom_screen.dart';
import 'package:sports_matching/screens/chat/evaluation_screen.dart';
import 'package:sports_matching/screens/home_screen.dart';
import 'package:sports_matching/screens/input/category_input_screen.dart';
import 'package:sports_matching/screens/input/input_screen.dart';
import 'package:sports_matching/screens/input/map_input_screen.dart';
import 'package:sports_matching/screens/search/search_screen.dart';
import 'package:sports_matching/states/category_notifier.dart';
import 'package:sports_matching/states/select_image_notifier.dart';
import 'package:sports_matching/states/user_notifier.dart';
import '../constants/data_keys.dart';
import '../screens/item/item_detail_screen.dart';
import 'package:provider/provider.dart';

const LOCATION_HOME = 'home';
const LOCATION_INPUT = 'input';
const LOCATION_ITEM = 'item';
const LOCATION_SEARCH = 'search';
const LOCATION_ITEM_ID = 'item_id';
const LOCATION_CHATROOM_ID = 'chatroom_id';
const LOCATION_CATEGORY_INPUT = 'category_input';
const LOCATION_EVALUATION_ID = 'evaluation_id';
const LOCATION_MAP_INPUT = 'map_input';





class HomeLocation extends BeamLocation{
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(child: HomeScreen(), key: ValueKey(LOCATION_HOME)),
      if(state.pathBlueprintSegments.contains(LOCATION_SEARCH))
        BeamPage(key: ValueKey(LOCATION_SEARCH), child: SearchScreen())

    ];
  }

  @override
  List get pathBlueprints => ['/', '${LOCATION_SEARCH}'];
}


class InputLocation extends BeamLocation{
  @override
  Widget builder(BuildContext context, Widget navigator) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: categoryNotifier),
          ChangeNotifierProvider(create: (context){return SelectImageNotifier();}),
        ],
      child: super.builder(context, navigator),
    );
    
  }
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if(state.pathBlueprintSegments.contains(LOCATION_INPUT))
        BeamPage(
            key: const ValueKey(LOCATION_INPUT),
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (BuildContext context) => SelectImageNotifier(),
                ),
                ChangeNotifierProvider.value(value: categoryNotifier),
              ],
              child: const InputScreen(),
            ),
        ),
      if(state.pathBlueprintSegments.contains(LOCATION_CATEGORY_INPUT))
        BeamPage(
            key: const ValueKey(LOCATION_CATEGORY_INPUT),
            child: ChangeNotifierProvider.value(value: categoryNotifier, child: const CategoryInputScreen(),)
        ),
      if(state.pathBlueprintSegments.contains(LOCATION_MAP_INPUT))
        BeamPage(
            key: const ValueKey(LOCATION_MAP_INPUT),
            child: MapInputScreen(context.read<UserNotifier>().userModel!),
        ),
    ];
  }

  @override
  List get pathBlueprints =>['/$LOCATION_INPUT', '/$LOCATION_INPUT/$LOCATION_CATEGORY_INPUT', '/$LOCATION_INPUT/$LOCATION_MAP_INPUT'];

}

class ItemLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {

      return [
      ...HomeLocation().buildPages(context, state),
      if(state.pathParameters.containsKey(LOCATION_ITEM_ID))
        BeamPage(key: ValueKey(LOCATION_ITEM_ID), child: ItemDetailScreen(state.pathParameters[LOCATION_ITEM_ID]??""),),
      if(state.pathParameters.containsKey(LOCATION_CHATROOM_ID))
        BeamPage(key: ValueKey(LOCATION_CHATROOM_ID), child: ChatroomScreen(chatroomKey:state.pathParameters[LOCATION_CHATROOM_ID]??""),),
      if(state.pathParameters.containsKey(LOCATION_EVALUATION_ID))
        BeamPage(key: ValueKey(LOCATION_EVALUATION_ID), child: EvalutionScreen())

    ];
  }

  @override
  List get pathBlueprints =>['/$LOCATION_ITEM/:$LOCATION_ITEM_ID/:$LOCATION_CHATROOM_ID/:$LOCATION_EVALUATION_ID', '/:$LOCATION_CHATROOM_ID/:$LOCATION_EVALUATION_ID',];

}