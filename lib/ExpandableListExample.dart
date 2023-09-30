// expandable_list_example.dart

// lists.dart 파일 import
import 'package:flutter/material.dart';
import 'lists.dart';
import 'main.dart';

class ExpandableListExample extends StatefulWidget {
  final Function onExpand;
  String listTitle;

  final Function(String, bool, {int box}) onSendMessage;
  ExpandableListExample(
      {required this.onExpand,
      required this.listTitle,
      required this.onSendMessage});

  @override
  _ExpandableListExampleState createState() => _ExpandableListExampleState();
}

class _ExpandableListExampleState extends State<ExpandableListExample> {
  bool _isExpanded = false;
  ScrollController _scrollController = ScrollController();

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    widget.onExpand(); // onExpand 콜백 함수 호출
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return FractionallySizedBox(
      widthFactor: 1,
      child: ExpansionPanelList(
        elevation: 1,
        expandedHeaderPadding: EdgeInsets.all(0),
        expansionCallback: (int index, bool isExpanded) {
          _toggleExpand();
        },
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Container(
                height: 0,
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                      255, 235, 237, 238), // 버튼의 색상을 #989898로 설정했습니다.
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2), // 왼쪽 상단 모서리를 둥글게 만들었습니다.
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '    ${widget.listTitle}', // 여기에 버튼 안의 텍스트를 입력하세요.
                    style: TextStyle(
                      fontSize: 14, // 여기에 텍스트 크기를 설정하세요.
                      color: Color(0xFF989898), // 여기에 텍스트 색상을 설정하세요.
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
            // 나머지 코드 생략
            body: Scrollbar(
              controller: _scrollController,
              isAlwaysShown: true,
              child: Container(
                height: screenHeight * 0.23,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  controller: _scrollController,
                  itemCount: (widget.listTitle == '실시간 TOP 질문')
                      ? topQuestionsList.length // lists.dart 파일에서 가져온 리스트 사용
                      : theSelectionList.length, // lists.dart 파일에서 가져온 리스트 사용
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: screenHeight * 0.05,
                      child: TextButton(
                        onPressed: () {
                          if (widget.listTitle == '실시간 TOP 질문') {
                            print(topQuestionsList[
                                index]); // lists.dart 파일에서 가져온 리스트 사용
                            widget.onSendMessage(topQuestionsList[index],
                                false); // lists.dart 파일에서 가져온 리스트 사용
                            //여기에 추가시켜줘
                          } else {
                            print(theSelectionList[
                                index]); // lists.dart 파일에서 가져온 리스트 사용
                            widget.onSendMessage(theSelectionList[index],
                                false); // lists.dart 파일에서 가져온 리스트 사용
                          }
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black, // 원하는 색상으로 변경하세요.
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text((widget.listTitle == '실시간 TOP 질문')
                              ? topQuestionsList[
                                  index] // lists.dart 파일에서 가져온 리스트 사용
                              : theSelectionList[
                                  index]), // lists.dart 파일에서 가져온 리스트 사용
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // 나머지 코드 생략

            isExpanded: _isExpanded,
          ),
        ],
      ),
    );
  }
}
