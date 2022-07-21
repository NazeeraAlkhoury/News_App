import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/modules/webview/web_view.dart';

Widget defaultFormFaild({
  required TextEditingController controller,
  required String label,
  required IconData prefix,
  required TextInputType type,
  Function? onSubmitted,
  Function? onChanged,
  required Function validated,
  bool isObscure: false,
  IconData? suffix,
  Function? onSuffix,
  Function? onTap,
  //bool isSuffix = false,
}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            prefix,
          ),
          border: OutlineInputBorder(),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    onSuffix!();
                  },
                  icon: Icon(
                    suffix,
                  ),
                )
              : null),
      keyboardType: type,
      onFieldSubmitted: (s) {
        onSubmitted!(s);
      },
      // onChanged: (String? s) {
      //   onChanged!(s!);
      // },
      onChanged: (s) {
        onChanged!(s);
      },
      validator: (String? value) {
        return validated(value!);
      },
      obscureText: isObscure,

      onTap: () {
        onTap!();
      },
      // validator: (String? value) {
      //   if (value!.isEmpty) {
      //     return 'Email Adress must not be empty ';
      //   }
      //   return null;
      // },
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
    );

Widget buildArticalItem(artical, context) => InkWell(
      onTap: () => navigateTo(context, WebViewScreen('${artical['url']}')),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(10.0),

                image: artical['urlToImage'] != null
                    ? DecorationImage(
                        image: NetworkImage(
                          '${artical['urlToImage']}',
                        ),

                        fit: BoxFit.cover,

                        onError: (exception, stackTrace) {
                          print('Image provider Exception');

                          print('${exception.toString()}');
                        },

                        // onError: (exception, stackTrace) => DecorationImage(

                        //   image: NetworkImage(

                        //     'https://clipground.com/images/question-mark-clipart-png-4.jpg',

                        //   ),

                        //   fit: BoxFit.cover,

                        // ),
                      )
                    : DecorationImage(
                        image: NetworkImage(
                          'https://clipground.com/images/question-mark-clipart-png-4.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),

                //  DecorationImage(

                //   image: NetworkImage(

                //     '${artical['urlToImage']}',

                //   ),

                //   fit: BoxFit.cover,

                //   onError: (exception, stackTrace) {

                //     print('nnnnnnnnnnnn');

                //   },

                // ),

                // image: DecorationImage(

                //   image: artical['urlToImage'] != null

                //       ? NetworkImage(

                //           '${artical['urlToImage']}',

                //         )

                //       : NetworkImage(

                //           'https://clipground.com/images/question-mark-clipart-png-4.jpg',

                //         ),

                //   fit: BoxFit.cover,

                // ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${artical['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      '${artical['publishedAt']}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articalBuilder(list, context, {bool isSearch = false}) => BuildCondition(
      condition: list.length > 0,
      builder: (context) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticalItem(list[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: list.length,
        );
      },
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
