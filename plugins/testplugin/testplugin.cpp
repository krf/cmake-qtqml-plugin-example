#include "testplugin.h"

#include <QDebug>

QString TestPlugin::name() const
{
    qDebug() << "getting name";
    return m_name;
}

void TestPlugin::setName(const QString& name)
{
    qDebug() << "setting name to:" << name;
    m_name = name;
}
