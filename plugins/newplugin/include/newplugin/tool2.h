#ifndef TOOL2_H
#define TOOL2_H

#include "scopy-newplugin_export.h"
#include <QWidget>

namespace scopy::newplugin {
class SCOPY_NEWPLUGIN_EXPORT Tool2 : public QWidget
{
	Q_OBJECT
public:
	Tool2(QWidget *parent = nullptr);
	~Tool2();
};
} // namespace scopy::newplugin
#endif // TOOL2_H
