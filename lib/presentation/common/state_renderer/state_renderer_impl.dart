import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_revision2/app/constants.dart';
import 'package:flutter_clean_arch_revision2/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_clean_arch_revision2/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//LoadingState (popUp,Full Screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState({
    required this.stateRendererType,
    this.message = AppStrings.loading,
  });

  @override
  String getMessage() => message ?? AppStrings.loading;
  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//ErrorState (popUp,Full Screen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(
    this.stateRendererType,
    this.message,
  );

  @override
  String getMessage() => message;
  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//ContentState
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constants.empty;
  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

//EmptyState
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);

  @override
  String getMessage() => message;
  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

class SuccessState extends FlowState {
  String message;
  SuccessState(this.message);

  @override
  String getMessage() => message;
  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.poupSuccessState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget contentScreenWidget,
    Function retryActionFunction,
  ) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.poupLoadingState) {
            //show popUp loading state
            showPopUp(
              context,
              getStateRendererType(),
              getMessage(),
            );
            //show content UI of screen
            return contentScreenWidget;
          } else {
            //full screen loading state
            return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ErrorState:
        //check if ther is an old dialog dosnot close , close it before show the new one
        dismissableDialog(context);
        {
          if (getStateRendererType() == StateRendererType.poupErrorState) {
            //show popUp error state
            showPopUp(
              context,
              getStateRendererType(),
              getMessage(),
            );
            //show content UI of screen
            return contentScreenWidget;
          } else {
            //full screen error state
            return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: () {},
          );
        }
      case ContentState:
        {
          dismissableDialog(context);
          return contentScreenWidget;
        }
      case SuccessState:
        {
          dismissableDialog(context);
          showPopUp(
            context,
            StateRendererType.poupSuccessState,
            getMessage(),
            title: AppStrings.success,
          );
          return contentScreenWidget;
        }
      default:
        {
          dismissableDialog(context);
          return contentScreenWidget;
        }
    }
  }

  showPopUp(
      BuildContext context, StateRendererType stateRendererType, String message,
      {String title = Constants.empty}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          retryActionFunction: () {}, //emptyFunction
        ),
      ),
    );
  }

  //check if ther is a gialog opend ?
  // if it return true mean ther is dialog open
  // if it return false mean ther is No dialog open
  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissableDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
}
