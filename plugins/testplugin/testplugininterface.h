#pragma once

#include <QtPlugin>

class QString;

#define TESTPLUGININTERFACE_IID "com.example.TestPluginInterface"

class TestPluginInterface
{
public:
    virtual ~TestPluginInterface() {}

    virtual QString name() const = 0;
    virtual void setName(const QString& name) = 0;
};

Q_DECLARE_INTERFACE(TestPluginInterface, TESTPLUGININTERFACE_IID)
