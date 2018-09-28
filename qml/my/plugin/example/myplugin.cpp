#include "myplugin.h"

#include <QtQml/QtQml>

#include "config.h"

#include "myquickitem.h"

void MyPlugin::registerTypes(const char* uri)
{
    qDebug() << "TEST:" << PLATFORM;

    // Register our 'MyQuickItem' in qml engine
    qmlRegisterType<MyQuickItem>(uri, 1, 0, "MyQuickItem");
}
