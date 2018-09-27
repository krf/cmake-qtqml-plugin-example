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
    const QString qmlPluginsDir = app.applicationDirPath() + "/../qml";
    // Add import search path
    qDebug() << "Adding import path for QML plugins:" << qmlPluginsDir;
    engine.addImportPath(qmlPluginsDir);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
