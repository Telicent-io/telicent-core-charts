# Changelog

## 0.1.0 (2025-04-10)


### Features

* chart system-mesh ([54dc213](https://github.com/Telicent-io/singlenode/commit/54dc213351a5cdcad6c698ffaa62caa2b5560d8e))
* move kafka to tc-system ([463b7e8](https://github.com/Telicent-io/singlenode/commit/463b7e81c341acb89a774d7719d50a1960db52c4))
* update system chart ([a8f384d](https://github.com/Telicent-io/singlenode/commit/a8f384d95fd3b2095c38562008a2722b504def1f))
* update system-mesh chart ([186de43](https://github.com/Telicent-io/singlenode/commit/186de43c43f1d724058a3fcb25a33b4a087be292))


### Bug Fixes

* add specific permissive peerauthN for kafka and remove deny by default authZpolicy which blocked operator to kafka traffic ([f1ac900](https://github.com/Telicent-io/singlenode/commit/f1ac900f9ccd7b53fc0f366c71dcb6db2eb94bbe))
* for now disable mTLS to kafka cluster pod because both the operator (no mTLS) and SCG (mTLS) will conflict if a authorizationpolicy selector matches the kafka pod ([26c1420](https://github.com/Telicent-io/singlenode/commit/26c1420064771e11cb2316abad814ceed2496c50))
* resolve helm install warnings/incomplete resources due to indent issues ([0a8b60e](https://github.com/Telicent-io/singlenode/commit/0a8b60e736c557a3721c3671e8f23c3e3d5bc3b8))
