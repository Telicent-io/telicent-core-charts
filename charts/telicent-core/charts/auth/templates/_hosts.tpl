{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
This file contains the names of other host/service(s) and serviceAccount(s) on which this
application relies on. They are defined here and referenced in resources such as config maps and istio.

The default behaviour when installing through the parent chart 'telicent-core' is the releasename
being prefixed to all sub-chart resources.
Example: naming a release 'core', will result in 'core-auth-*' resources being generated.
The helpers functions in this file is used to update those references accordingly.

To allow for short name resources across all applications, when installing through the parent chart:
Set 'fullnameOverride' equivalent to the sub-cart name and 'hosts.enableAutoCorrect: false' on all sub-charts.
Doing so will correctly configure the whole system.
*/}}

{{/*
Detailed description of 'discoverService' function
1.a) Installed through the parent chart, the service name will include the release name.
1.b) Installed through the parent chart, where 'hosts.enableAutoCorrect: false' has been set on the sub-chart.
     Will result in the release name *not* being included.
2.)  Installed through a sub chart, where the release name is set to 'auth' (identical to the chart name).
     The release name will *not* be included.
*/}}

{{/*
Returns the service/serviceAccount with or without a release name.
*/}}

