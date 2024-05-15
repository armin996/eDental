import 'package:reflectable/reflectable.dart';

class ReflectCustomClass extends Reflectable {
  const ReflectCustomClass()
      : super(
            declarationsCapability,
            reflectedTypeCapability,
            invokingCapability,
            instanceInvokeCapability,
            typeAnnotationDeepQuantifyCapability,
            typeRelationsCapability,
            typeCapability,
            metadataCapability);
}

const reflector = ReflectCustomClass();
