import UIKit

GomokuGame.dataFactory = GameDataFactoryImpl()

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    NSStringFromClass(Application.self),
    NSStringFromClass(AppDelegate.self)
)
