import 'package:code_editor/code_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_compiler/models/RecentFile.dart';

import '../../../constants.dart';

List<String> contentOfPage1 = [
  """
  (defn create-profile
  [options]
  (let [system   (init-system)
        email    (or (:email options)
                     (read-from-console {:label "Email:"}))
        fullname (or (:fullname options)
                     (read-from-console {:label "Full Name:"}))
        password (or (:password options)
                     (read-from-console {:label "Password:"
                                         :type :password}))]
    (try
      (db/with-atomic [conn (:app.db/pool system)]
        (->> (auth/create-profile! conn
                                  {:fullname fullname
                                   :email email
                                   :password password
                                   :is-active true
                                   :is-demo false})
             (auth/create-profile-rels! conn)))

      (when (pos? (:verbosity options))
        (println "User created successfully."))

      (System/exit 0)

      (catch Exception _e
        (when (pos? (:verbosity options))
          (println "Unable to create user, already exists."))
        (System/exit 1)))))

(defn reset-password
  [options]
  (let [system (init-system)]
    (try
      (db/with-atomic [conn (:app.db/pool system)]
        (let [email    (or (:email options)
                           (read-from-console {:label "Email:"}))
              profile  (profile/get-profile-by-email conn email)]
          (when-not profile
            (when (pos? (:verbosity options))
              (println "Profile does not exists."))
            (System/exit 1))

          (let [password (or (:password options)
                             (read-from-console {:label "Password:"
                                                 :type :password}))]
            (profile/update-profile-password! conn (assoc profile :password password))
            (when (pos? (:verbosity options))
              (println "Password changed successfully.")))))
      (System/exit 0)
      (catch Exception e
        (when (pos? (:verbosity options))
          (println "Unable to change password."))
        (when (= 2 (:verbosity options))
          (.printStackTrace e))
        (System/exit 1)))))
  """
];

// The files displayed in the navigation bar of the editor.
// You are not limited.
// By default, [name] = "file.${language ?? 'txt'}", [language] = "text" and [code] = "",
List<FileEditor> files = [
  FileEditor(
    name: "Example1.clj",
    language: "clojure",
    code: contentOfPage1.join("\n"), // [code] needs a string
  ),
  FileEditor(
    name: "SomeDraft.clj",
    language: "clojure",
    code: "<a href='page1.html'>go back</a>",
  ),
  FileEditor(
    name: "AnotherExample.clj",
    language: "css",
    code: "a { color: red; }",
  ),
];
EditorModel model = EditorModel(
  files: files, // the files created above
  // you can customize the editor as you want
  styleOptions: EditorModelStyleOptions(
    fontSize: 13,
  ),
);

final _selectedColor = Color(0xff2E3152);
final _unselectedColor = Color(0xff5f6368);
final _tabs = [
  Tab(text: 'Code Snippet'),
  Tab(text: 'Lexer'),
  Tab(text: 'AST chart'),
];

final _iconTabs = [
  Tab(icon: Icon(Icons.home)),
  Tab(icon: Icon(Icons.search)),
  Tab(icon: Icon(Icons.settings)),
];

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// Custom Tabbar with solid selected bg and transparent tabbar bg
            Container(
              height: kToolbarHeight + 8.0,
              padding:
              const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
              decoration: BoxDecoration(
                color: _selectedColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    color: Colors.white),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                tabs: _tabs,
              ),
            ),
            CodeEditor(
              model: model,
              edit: true,
              disableNavigationbar: false,
              onSubmit: (String? language, String? value) {},
              textEditingController: TextEditingController(text: 'hello!'),
            ),
          ],
        ),
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),
    ],
  );
}
