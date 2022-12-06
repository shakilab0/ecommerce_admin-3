import 'package:flutter/material.dart';

import '../models/dashboard_model.dart';

class DashboardItemView extends StatelessWidget {
  final DashboardModel model;
  final Widget? badge;
  const DashboardItemView({Key? key, required this.model,this.badge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.pushNamed(context, model.routeName),
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Icon(model.iconData,size: 50,color: Theme.of(context).primaryColor,),
                  if(badge!=null)badge!,
                ],
              ),
              const SizedBox(height: 10,),
              Text(model.title,style: Theme.of(context).textTheme.headline5,)
            ],
          ),
        ),
      ),
    );
  }
}
