import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_color.dart';
import 'package:socia/core/utility/dummypicturelink.dart';
import 'package:socia/core/widgets/app_bar_title.dart';
import 'package:socia/core/widgets/back_button_svg.dart';
import 'package:socia/core/widgets/button_text.dart';
import 'package:socia/core/widgets/fo_ufmsg_button.dart';

import '../../../../core/widgets/follower_followingButton.dart';
import '../../../../core/widgets/form_text_field.dart';

class FollowUnfollowScreen extends StatefulWidget {
  const FollowUnfollowScreen({super.key});

  @override
  State<FollowUnfollowScreen> createState() => _FollowUnfollowScreenState();
}

class _FollowUnfollowScreenState extends State<FollowUnfollowScreen> with SingleTickerProviderStateMixin{
  final TextEditingController _searchTEC=TextEditingController();
   late TabController _tabController;
   bool _isFollow= true;
   bool _isBgColor= false;

 void _toggleButtonProperty(){
  _isFollow = !_isFollow;
  _isBgColor= !_isBgColor;
  setState(() {});
 }
   void _onTap(int index){
     setState(() {
       _tabController.index=index;
     });
   }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButtonSvg(),
        title: const AppBarTitle(title: 'UserName'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8,left: 16,right: 16, ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FollowerFollowingButton(
                    text: 'Following',
                    onPressed: ()=> _onTap(0),
                  isSelected: _tabController.index==0,),
                FollowerFollowingButton(
                    text: 'Follower',
                    onPressed: ()=> _onTap(1) ,
                  isSelected: _tabController.index==1,)
              ],
            ),
             Divider(height: 1,color: Colors.grey.shade300,),
            const SizedBox(height: 10,),
            FormTextField(
              controller: _searchTEC,
              prefixIcon: const Icon(Icons.search_outlined),
              hintText: 'Search',
              boxWidth: 343,
              boxHeight: 36,
              borderSideColor: Colors.grey,
            ),
            const SizedBox(height: 8,),
            Expanded(
              child: TabBarView(
                clipBehavior: Clip.antiAlias,
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(DummyUrlImage.profile),
                        ),
                        title: const Text(
                          'Display Name',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: const Text('userName321',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12)),
                        trailing: FoUnfMsgButton(
                          onPressed: (){
                            _toggleButtonProperty();
                          },
                          isReverseBgColor: true,
                          isFollow: _isFollow,
                          isBgColorGrey: _isBgColor,
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return  ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(DummyUrlImage.profile),
                        ),
                        title: const Text(
                          'Display Name',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        trailing: FoUnfMsgButton(
                          onPressed: (){
                            showBottomSheetToRemove();
                          },
                          isBgColorGrey: true,
                          text: 'Remove',
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showBottomSheetToRemove() {
    showModalBottomSheet(
        context: context,
        barrierColor: AppColors.primaryColor.withOpacity(0.25),
        constraints: const BoxConstraints(maxHeight: 124),
        shape: const Border(left: BorderSide(style: BorderStyle.solid)),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(DummyUrlImage.profile),
                  ),
                  title: const Text(
                    'Display Name',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                const Divider(height: 2,),
                const SizedBox(height: 8,),
                ButtonText(onPressed: (){}, textA: 'Remove',needColor: Colors.redAccent,)
              ],
            ),
          );
        });
  }
   @override
   void dispose() {
     _tabController.dispose();
     super.dispose();
   }
}


