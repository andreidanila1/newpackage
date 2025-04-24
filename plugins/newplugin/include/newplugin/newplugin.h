#ifndef NEWPLUGIN_H
#define NEWPLUGIN_H

#define SCOPY_PLUGIN_NAME NEWPlugin


#include "scopy-newplugin_export.h"
#include <QObject>
#include <pluginbase/plugin.h>
#include <pluginbase/pluginbase.h>

namespace scopy::newplugin {
class SCOPY_NEWPLUGIN_EXPORT NEWPlugin : public QObject, public PluginBase
{
	Q_OBJECT
	SCOPY_PLUGIN;

public:
	bool compatible(QString m_param, QString category) override;
	bool loadPage() override;
	bool loadIcon() override;
	void loadToolList() override;
	void unload() override;
	void initMetadata() override;
	QString description() override;

public Q_SLOTS:
	bool onConnect() override;
	bool onDisconnect() override;
};
} // namespace scopy::newplugin
#endif // NEWPLUGIN_H
