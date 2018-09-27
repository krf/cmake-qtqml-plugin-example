#pragma once

#include "testplugininterface.h"

#include <QObject>
#include <QString>
#include <QtPlugin>

class TestPlugin : public QObject, public TestPluginInterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID TESTPLUGININTERFACE_IID)
    Q_INTERFACES(TestPluginInterface)

public:
    ~TestPlugin() override {}

    QString name() const override;
    void setName(const QString &name) override;

private:
    QString m_name = QStringLiteral("hello world");
};
