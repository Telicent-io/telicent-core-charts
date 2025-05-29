# Telicent CORE Helm 
---
Points for discussion: 
- The secrets created will not create a working install as they are created empty
    - Inclusion of the Strimzi cluster creation would allow for the user secrets to be populated and shared?
- Added values that must be commented out else the charts will look for secrets that don't exist, I don't believe this is an anti-pattern, but potential discussion point?








