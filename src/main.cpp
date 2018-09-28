#include "../plugins/testplugin/testplugininterface.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QDir>
#include <QPluginLoader>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    // Playing around with the test Qt plugin
    {
        // Also check: https://doc.qt.io/qt-5/qtwidgets-tools-plugandpaint-app-example.html
        TestPluginInterface* testPlugin = nullptr;

        const QDir pluginsDir = app.applicationDirPath() + "/../plugins/";
        qDebug() << "Searching for Qt plugins in:" << pluginsDir;
        const auto entryList = QDir(pluginsDir).entryList(QDir::Files);
        for (const QString &fileName : entryList) {
            const auto filePath = pluginsDir.absoluteFilePath(fileName);
            qDebug() << "Checking file:" << filePath;
            QPluginLoader loader(pluginsDir.absoluteFilePath(fileName));
            if (auto instance = loader.instance()) {
                if ((testPlugin = qobject_cast<TestPluginInterface*>(instance))){
                    break; // found
                }
            } else {
              qDebug() << loader.errorString();
            }
        }

        if (testPlugin) {
            qDebug() << "TestPluginInterface::name():" << testPlugin->name();
        } else {
            qWarning() << "Failed to find testplugin!";
        }
    }

    QQmlApplicationEngine engine;

    QDir pluginsDir(app.applicationDirPath());
#if defined(Q_OS_WIN)
    if (pluginsDir.dirName().toLower() == "debug" || pluginsDir.dirName().toLower() == "release")
        pluginsDir.cdUp();
#elif defined(Q_OS_MAC)
    if (pluginsDir.dirName() == "MacOS") {
        pluginsDir.cdUp();
        pluginsDir.cdUp();
        pluginsDir.cdUp();
    }
#endif
    pluginsDir.cdUp();
    pluginsDir.cd("qml");

    // Add import search path
    qDebug() << "Adding import path for QML plugins:" << pluginsDir.path();
    engine.addImportPath(pluginsDir.path());
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
