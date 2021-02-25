#
# Copyright (c) ZeroC, Inc. All rights reserved.
#

$(test)_dependencies = TestCommon IceSSL Ice

#
# Disable var tracking assignments for Linux with this test
#


# Need to load certificates with functions from src/IceSSL/Util.h
$(test)[iphoneos]_cppflags              := -Isrc
$(test)[iphonesimulator]_cppflags       := -Isrc

tests += $(test)
