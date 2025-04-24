#ifndef TOOL1_H
#define TOOL1_H

#include "scopy-newplugin_export.h"
#include <QWidget>

namespace scopy::newplugin {
class SCOPY_NEWPLUGIN_EXPORT Tool1 : public QWidget
{
	Q_OBJECT
public:
	Tool1(QWidget *parent = nullptr);
	~Tool1();
};
} // namespace scopy::newplugin
#endif // TOOL1_H
