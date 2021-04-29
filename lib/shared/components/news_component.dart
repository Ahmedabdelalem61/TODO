import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_todo/modules/web_view/web_view_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget BuildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      navigateTo(
        context,
        WebViewScreen(article['url']),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.fill)),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.body1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    article['publishedAt'],
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget ItemDivider() {
  return Padding(
    padding: const EdgeInsets.only(left: 25.0),
    child: Divider(color: Colors.grey.shade500),
  );
}

Widget ArticleBuilder(list, context,{isSearch = false}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    fallback: isSearch?(context) =>Container():(context) => Center(child: CircularProgressIndicator()),
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => BuildArticleItem(list[index], context),
        separatorBuilder: (context, index) => ItemDivider(),
        itemCount: 10),
  );
}

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
