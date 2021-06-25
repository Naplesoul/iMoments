import 'package:flutter/material.dart';

class CustomRouteVerticalUp extends PageRouteBuilder{
  final Widget widget;

  CustomRouteVerticalUp(this.widget)
      :super(
    // 设置过度时间
      transitionDuration:Duration(milliseconds: 700),
      // 构造器
      pageBuilder:(
          // 上下文和动画
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
          ){
        return widget;
      },
      transitionsBuilder:(
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
          Widget child,
          ){

        return SlideTransition(
          position: Tween<Offset>(
            // 设置滑动的 X , Y 轴
            begin: Offset(0.0, 1.0),
            end: Offset(0.0,0.0)
          ).animate(CurvedAnimation(
            parent: animaton1,
            curve: Curves.fastOutSlowIn
          )),
          child: child,
        );
      }
  );
}

class CustomRouteTransition extends PageRouteBuilder{
  final Widget widget;

  CustomRouteTransition(this.widget)
      :super(
    // 设置过度时间
      transitionDuration:Duration(milliseconds: 700),
      // 构造器
      pageBuilder:(
          // 上下文和动画
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
          ){
        return widget;
      },
      transitionsBuilder:(
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
          Widget child,
          ){

        // 缩放动画效果
        return ScaleTransition(
          scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
            parent: animaton1,
            curve: Curves.fastOutSlowIn
          )),
          child: child,
        );
      }
  );
}

class CustomRouteVerticalDown extends PageRouteBuilder{
  final Widget widget;

  CustomRouteVerticalDown(this.widget)
      :super(
    // 设置过度时间
      transitionDuration:Duration(milliseconds: 700),
      // 构造器
      pageBuilder:(
          // 上下文和动画
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
          ){
        return widget;
      },
      transitionsBuilder:(
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
          Widget child,
          ){

        return SlideTransition(
          position: Tween<Offset>(
            // 设置滑动的 X , Y 轴
              begin: Offset(0.0, -1.0),
              end: Offset(0.0,0.0)
          ).animate(CurvedAnimation(
              parent: animaton1,
              curve: Curves.fastOutSlowIn
          )),
          child: child,
        );
      }
  );
}

class CustomRouteHorizontal extends PageRouteBuilder{
  final Widget widget;

  CustomRouteHorizontal(this.widget)
      :super(
    // 设置过度时间
      transitionDuration:Duration(milliseconds: 530),
      // 构造器
      pageBuilder:(
          // 上下文和动画
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
          ){
        return widget;
      },
      transitionsBuilder:(
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
          Widget child,
          ){

        // 渐变效果
        // return FadeTransition(
        //   // 从0开始到1
        //   opacity: Tween(begin: 0.0,end: 1.0)
        //       .animate(CurvedAnimation(
        //     // 传入设置的动画
        //     parent: animaton1,
        //     // 设置效果，快进漫出   这里有很多内置的效果
        //     curve: Curves.fastOutSlowIn,
        //   )),
        //   child: child,
        // );

        // 缩放动画效果
        // return ScaleTransition(
        //   scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
        //     parent: animaton1,
        //     curve: Curves.fastOutSlowIn
        //   )),
        //   child: child,
        // );

        // 旋转加缩放动画效果
        // return RotationTransition(
        //   turns: Tween(begin: 0.0,end: 1.0)
        //   .animate(CurvedAnimation(
        //     parent: animaton1,
        //     curve: Curves.fastOutSlowIn,
        //   )),
        //   child: ScaleTransition(
        //     scale: Tween(begin: 0.0,end: 1.0)
        //     .animate(CurvedAnimation(
        //       parent: animaton1,
        //       curve: Curves.fastOutSlowIn
        //     )),
        //     child: child,
        //   ),
        // );

        return SlideTransition(
          position: Tween<Offset>(
            // 设置滑动的 X , Y 轴
              begin: Offset(1.0, 0.0),
              end: Offset(0.0,0.0)
          ).animate(CurvedAnimation(
              parent: animaton1,
              curve: Curves.fastOutSlowIn
          )),
          child: child,
        );
      }
  );
}

class CustomRouteFade extends PageRouteBuilder{
  final Widget widget;

  CustomRouteFade(this.widget)
      :super(
    // 设置过度时间
      transitionDuration:Duration(milliseconds: 800),
      // 构造器
      pageBuilder:(
          // 上下文和动画
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
          ){
        return widget;
      },
      transitionsBuilder:(
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
          Widget child,
          ){

        // 渐变效果
        return FadeTransition(
          // 从0开始到1
          opacity: Tween(begin: 0.0,end: 1.0)
              .animate(CurvedAnimation(
            // 传入设置的动画
            parent: animaton1,
            // 设置效果，快进漫出   这里有很多内置的效果
            curve: Curves.fastOutSlowIn,
          )),
          child: child,
        );

        // 缩放动画效果
        // return ScaleTransition(
        //   scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
        //     parent: animaton1,
        //     curve: Curves.fastOutSlowIn
        //   )),
        //   child: child,
        // );
      }
  );
}