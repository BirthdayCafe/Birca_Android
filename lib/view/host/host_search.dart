import 'package:birca/view/host/host_search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../designSystem/palette.dart';
import '../../viewModel/host_home_view_model.dart';
import '../../viewModel/host_search_result_view_model.dart';

class HostSearch extends StatefulWidget {
  const HostSearch({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HostSearch();
  }
}

class _HostSearch extends State<HostSearch> {
  bool isTab = false;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(left: 17, right: 17, top: 30),
              height: 40,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        await Provider.of<HostHomeViewModel>(context,
                                listen: false)
                            .getHostHome(0, 3, "",false,"","")
                            .then((value) => Navigator.pop(context));
                      },
                      icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(fontSize: 14),
                      onChanged: (text) {},
                      decoration: const InputDecoration(
                          //비활성화
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.primary),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(37))),

                          //활성화
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.primary),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(37))),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10)),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Consumer<HostSearchResultViewModel>(
                      builder: (context, viewModel, child) {
                    return IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HostSearchResult(
                                  keyword: searchController.text.toString(),
                                )));
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Palette.primary,
                        size: 25,
                      ),
                    );
                  })
                ],
              ))
        ],
      )),
    );
  }
}
