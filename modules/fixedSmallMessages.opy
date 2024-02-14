#!define fixedString(str) "{0}{1}".format("   ", str)
#!define fixedStringWithIcon(icon, str) "{0}{1}".format("   {}  ".format(icon), str)

#!define fixedSmallMessage(visibility, str) smallMessage(visibility, fixedString(str))
#!define fixedSmallMessageWithIcon(visibility, icon, str) smallMessage(visibility, fixedStringWithIcon(icon, str))