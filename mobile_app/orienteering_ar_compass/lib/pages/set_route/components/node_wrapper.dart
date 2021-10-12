import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart' as gv;

nodeWrapper(Function()? onTap, Widget child) => gv.Node(
      InkWell(
        onTap: onTap,
        child: child,
      ),
    );
