# Changelog

## [1.1.5](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v1.1.4...telicent-core-v1.1.5) (2026-02-17)


### Bug Fixes

* add feature flag for mapv2 ([19ca319](https://github.com/Telicent-io/telicent-core-charts/commit/19ca3196783befb69531fbb47e2809f0f5817b82))
* postgres no longer assumed as default in error ([7d6d460](https://github.com/Telicent-io/telicent-core-charts/commit/7d6d4606aaa6b443d0292326d2159fc4ac0cc80f))
* postgres no longer assumed as default in error ([7246db4](https://github.com/Telicent-io/telicent-core-charts/commit/7246db480422034fd955525ff5e200b7a4144197))

## [1.1.4](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v1.1.3...telicent-core-v1.1.4) (2026-02-09)


### Bug Fixes

* allow graph traffic in OSS ([2e24bde](https://github.com/Telicent-io/telicent-core-charts/commit/2e24bde160869d325f3a76a0a049631810912273))

## [1.1.3](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v1.1.2...telicent-core-v1.1.3) (2026-02-04)


### Bug Fixes

* bump graph-ui ([8d555af](https://github.com/Telicent-io/telicent-core-charts/commit/8d555af5548f014f03b9b79b4d94580f9709b885))
* update app versions ([42620d6](https://github.com/Telicent-io/telicent-core-charts/commit/42620d61d9f5c20ef48c165c37f1ca31531496cd))
* update app versions ([9ff9491](https://github.com/Telicent-io/telicent-core-charts/commit/9ff9491c733d6e961f3f75453abf01a0112ab17e))

## [1.1.2](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v1.1.1...telicent-core-v1.1.2) (2026-02-02)


### Bug Fixes

* allow auth sessions and clients tokens to be specified though Helm values ([604030e](https://github.com/Telicent-io/telicent-core-charts/commit/604030e8a1052efb74f83a951568306e105296f3))
* core + preview ([8ad6e7f](https://github.com/Telicent-io/telicent-core-charts/commit/8ad6e7ff8346b9325e1f03d4fd3536132f11df76))
* core + preview release ([8506964](https://github.com/Telicent-io/telicent-core-charts/commit/85069644df88461ffa5b375e1f46a492de89a1de))

## [1.1.1](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v1.1.0...telicent-core-v1.1.1) (2026-01-23)


### Bug Fixes

* make host domain values required ([69ac812](https://github.com/Telicent-io/telicent-core-charts/commit/69ac812caf209346986d38997cc27391cc61d46d))
* removes all default resources and limits ([0a5d96d](https://github.com/Telicent-io/telicent-core-charts/commit/0a5d96dd5060c6c35ead510a3dc7daadf8bd095a))
* traefik ingress authz ([6e02866](https://github.com/Telicent-io/telicent-core-charts/commit/6e028661e2939b645fc49e0d1db17198f8f5c106))
* use correct label indentation for volume claim templates ([1d9451c](https://github.com/Telicent-io/telicent-core-charts/commit/1d9451c8168724faccefc456fd50f6cfe5584dfc))
* use correct label indentation for volume claim templates ([56faabf](https://github.com/Telicent-io/telicent-core-charts/commit/56faabf12638692572411bbf3c9bea08a85fb5c1))

## [1.1.0](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v1.0.0...telicent-core-v1.1.0) (2026-01-19)


### Features

* adds sc-spatial to preview ([980ae3b](https://github.com/Telicent-io/telicent-core-charts/commit/980ae3be8989efd983c139de10115a8856e17485))
* istio injection label now optional ([0b43299](https://github.com/Telicent-io/telicent-core-charts/commit/0b432998d16cc97cd85a35899ea0ddc305bd3860))
* istio injection label now optional ([e7b422c](https://github.com/Telicent-io/telicent-core-charts/commit/e7b422c0e0498dc4c551e6442d160afa78e33e08))


### Bug Fixes

* resource collision with no values file supplied ([1cb73b0](https://github.com/Telicent-io/telicent-core-charts/commit/1cb73b0742d485f82be4a03931cd376a131d7940))
* resource collision with no values file supplied ([aaf3e49](https://github.com/Telicent-io/telicent-core-charts/commit/aaf3e49b03a5708e49f3aa57d58301c58bc6c7dc))

## [1.0.0](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.5.0...telicent-core-v1.0.0) (2025-12-16)


### ⚠ BREAKING CHANGES

* New Auth image bump

### Features

* New Auth image bump ([93f3700](https://github.com/Telicent-io/telicent-core-charts/commit/93f3700a4be2a8596df3f5d63e4ae0ba9d639131))
* upversion admin-ui to 1.2.10 ([71b53fd](https://github.com/Telicent-io/telicent-core-charts/commit/71b53fd21d542da030459d70af8d174a270785c5))
* upversion admin-ui to 1.2.10 ([3d91a60](https://github.com/Telicent-io/telicent-core-charts/commit/3d91a602e2da30c3e37cfe6fe3ff0761e207dc5b))


### Bug Fixes

* Add 'auth' to chart dependencies. ([fa507bb](https://github.com/Telicent-io/telicent-core-charts/commit/fa507bbd8f41f5a4aaaa6c9fd6d3148b62122dab))
* Add Auth server chart. ([93ec589](https://github.com/Telicent-io/telicent-core-charts/commit/93ec5890fc178bb2b81286eba515ef71f86c87d9))
* Add Helm chart for Admin UI. ([6e7d5b6](https://github.com/Telicent-io/telicent-core-charts/commit/6e7d5b680efcceb3087a2f79a5eb276eee2d1d17))
* Add working Auth server chart. ([cff7a95](https://github.com/Telicent-io/telicent-core-charts/commit/cff7a9552adb9d902b4b95afefc038e70194a6e7))
* apply routing for auth pages favicon ([4d55e7e](https://github.com/Telicent-io/telicent-core-charts/commit/4d55e7e49d4480aaf00439c30637d061b4627a34))
* apply routing for auth pages favicon ([1da2b07](https://github.com/Telicent-io/telicent-core-charts/commit/1da2b07f393bccc2854f5834a4ad7c2a137ef5ef))
* apply routing for auth pages favicon ([79c4c91](https://github.com/Telicent-io/telicent-core-charts/commit/79c4c91ecc0b43afc491357da62b99269604fe38))
* apply routing for auth pages favicon ([e0c988b](https://github.com/Telicent-io/telicent-core-charts/commit/e0c988bf2487d2403727c06e257ae9d4beff325d))
* change claim attribute name and default ([c5136c4](https://github.com/Telicent-io/telicent-core-charts/commit/c5136c4668857561fa4b13f1fb723de62c76a84f))
* change claim attribute name and default ([3f70089](https://github.com/Telicent-io/telicent-core-charts/commit/3f70089afbe1bb1be72363e09d2290b90c2e2819))
* default projector index ([2ad63e1](https://github.com/Telicent-io/telicent-core-charts/commit/2ad63e107a3d5e9cf930401d7740f19e55d8fd17))
* default projector index ([1894231](https://github.com/Telicent-io/telicent-core-charts/commit/1894231d122d8645023e37c2a64b580158dbc563))
* missed silly access api requirement ([dcf3293](https://github.com/Telicent-io/telicent-core-charts/commit/dcf329351300f043b40fbc08e103e3ecf1a58f6a))
* missed silly access api requirement ([8219c7a](https://github.com/Telicent-io/telicent-core-charts/commit/8219c7a396d816c59f619716a873b17d7aa16493))
* re-remove oauth2 from session and put it on sessions for admin use ([476d910](https://github.com/Telicent-io/telicent-core-charts/commit/476d910e0f592dbe5182e0c8a628365ed15de873))
* re-remove oauth2 from session and put it on sessions for admin use ([3200ee0](https://github.com/Telicent-io/telicent-core-charts/commit/3200ee06823cee07df7916878b1191fb56104664))
* Remove dpuplcate 'ies-' from source name configuration value. ([419ef0d](https://github.com/Telicent-io/telicent-core-charts/commit/419ef0de9592a993bed6645ae564ffca0aac86a1))
* Remove duplicate 'ies-' from source name configuration value. ([a117a6e](https://github.com/Telicent-io/telicent-core-charts/commit/a117a6edf271536454fb6185117b950eabea06fa))
* remove oauth2 middleware ([ec187b8](https://github.com/Telicent-io/telicent-core-charts/commit/ec187b8893d4b6514d43c858d48d99fc41a70164))
* remove oauth2 middleware ([1931996](https://github.com/Telicent-io/telicent-core-charts/commit/1931996a2c0d8a53d2264baa92023a416403f7b1))
* update configmap for admin UI and CORS for FE local development ([caeecae](https://github.com/Telicent-io/telicent-core-charts/commit/caeecae5a208870e3179909720b0347cb0846d61))
* update configmap for admin UI and CORS for FE local development ([331db3f](https://github.com/Telicent-io/telicent-core-charts/commit/331db3fee2db7e8933af6a8c0a38a1f1c24af8ef))
* Update path to App Switcher icons ([6cde7a5](https://github.com/Telicent-io/telicent-core-charts/commit/6cde7a5fa68533b425517d5a16998bb24cedb288))
* Update path to App Switcher icons ([0042952](https://github.com/Telicent-io/telicent-core-charts/commit/0042952defd7563c191f28acc6d15727f143b51b))

## [0.5.0](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.4.2...telicent-core-v0.5.0) (2025-10-29)


### Features

* adds acled and canonicals ([3244782](https://github.com/Telicent-io/telicent-core-charts/commit/3244782c3de0a6590cad87a5d6bf3a282e188d2a))
* Adds conditional for parent chart to toggle the children ([ac1b4e6](https://github.com/Telicent-io/telicent-core-charts/commit/ac1b4e6acaf639e30dff856e9f37b0896c3407dc))
* adds data catalog chart ([3fe7ec9](https://github.com/Telicent-io/telicent-core-charts/commit/3fe7ec910e160fd4c53f75d485018402a0dc4f52))
* Adds document pipeline ([b581894](https://github.com/Telicent-io/telicent-core-charts/commit/b5818948941b95883cdef3c330ef72d534d0231c))
* Adds paperback writer ([aded282](https://github.com/Telicent-io/telicent-core-charts/commit/aded282509d3374a3e092975560bf731a9fc729c))
* adds sidecar support ([8d983d0](https://github.com/Telicent-io/telicent-core-charts/commit/8d983d06bac41fb57650cdb3becc1f47344ed8cd))
* adds sidecar support ([97c8697](https://github.com/Telicent-io/telicent-core-charts/commit/97c8697b1c426c22d6fbf7c6a5dd93d1f64e201f))
* adds user portal to telicent PREVIEW ([9cf1b4b](https://github.com/Telicent-io/telicent-core-charts/commit/9cf1b4bf4ccb657f823bfc0158eb247b7d04dea8))
* enable or disable istio virtualservice ([8b56448](https://github.com/Telicent-io/telicent-core-charts/commit/8b5644826a2e3b32fa92084fc24ac1a2f327b129))
* enable or disable istio virtualservice ([51cda8a](https://github.com/Telicent-io/telicent-core-charts/commit/51cda8a3cd8f59d38a3da5f1a513dbc1d79909a2))
* ies, rdf producers added ([f5ef457](https://github.com/Telicent-io/telicent-core-charts/commit/f5ef4571634d447ff89fa00e2d95941c48b271c0))
* upversion search to 4.17.1 ([230ea91](https://github.com/Telicent-io/telicent-core-charts/commit/230ea91397d16ba6275a86b61e79cc3180a38471))
* upversion search to 4.17.1 ([b10810e](https://github.com/Telicent-io/telicent-core-charts/commit/b10810e43a7e32c7205a947db79d8cd12bc445ca))


### Bug Fixes

* adds utility for cacert ([63bd2c7](https://github.com/Telicent-io/telicent-core-charts/commit/63bd2c761ea2363acb2060c38eb612bc8a3ad294))
* Default sparql Group ([3ecce30](https://github.com/Telicent-io/telicent-core-charts/commit/3ecce3013b517d807db2cd877280a3f3f7cca303))
* indentation on VirtualService ([7b968df](https://github.com/Telicent-io/telicent-core-charts/commit/7b968df4539603c89f2d75c05a866887fadb78d4))
* indentation on VirtualService ([2a17f15](https://github.com/Telicent-io/telicent-core-charts/commit/2a17f15ea9e58c41b2f2ed95970ec328ff2567a1))
* make CA cert volume override work as expected ([163aa3f](https://github.com/Telicent-io/telicent-core-charts/commit/163aa3f9f02c7647378b231209a2663e8214c5d1))
* make CA cert volume override work as expected ([e807b1e](https://github.com/Telicent-io/telicent-core-charts/commit/e807b1e13885d38bdfbc97dbcebef72980c65bfc))
* move topic creation to helm hook ([7f6cb2a](https://github.com/Telicent-io/telicent-core-charts/commit/7f6cb2a7260f8d25f3e9d52ed744f764a42d0d79))
* move topic creation to helm hook ([45e70e6](https://github.com/Telicent-io/telicent-core-charts/commit/45e70e64f18d218256b8d50674b16d77c876f4f1))
* parent chart dependency ([cdd0d18](https://github.com/Telicent-io/telicent-core-charts/commit/cdd0d18d8da6feb9bfc0403bdfda3f2e5b148f97))

## [0.4.2](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.4.1...telicent-core-v0.4.2) (2025-09-09)


### Features

* Adds NOTES.txt for post install information ([36605d4](https://github.com/Telicent-io/telicent-core-charts/commit/36605d4ecc03011d07a67e98c1f497fb1c68d064))

## [0.4.1](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.4.0...telicent-core-v0.4.1) (2025-09-04)


### Bug Fixes

* Add condition to `search` and `search-projector` sub-charts. ([#162](https://github.com/Telicent-io/telicent-core-charts/issues/162)) ([0af193c](https://github.com/Telicent-io/telicent-core-charts/commit/0af193c2417ffef9b12f9b54ab871caba4c9f9e6))

## [0.4.0](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.3.5...telicent-core-v0.4.0) (2025-08-24)


### Features

* standard naming ([#146](https://github.com/Telicent-io/telicent-core-charts/issues/146)) ([8121bb5](https://github.com/Telicent-io/telicent-core-charts/commit/8121bb599d5e2ea76a86525ff3251dae92c872d0))

## [0.3.5](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.3.4...telicent-core-v0.3.5) (2025-08-13)


### Bug Fixes

* Make mongo URL a secret ([#139](https://github.com/Telicent-io/telicent-core-charts/issues/139)) ([1811e83](https://github.com/Telicent-io/telicent-core-charts/commit/1811e83307ecb83d831de673f93d59a58fe0c54b))

## [0.3.4](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.3.3...telicent-core-v0.3.4) (2025-08-13)


### Bug Fixes

* Upversion images ([#137](https://github.com/Telicent-io/telicent-core-charts/issues/137)) ([87bc3fd](https://github.com/Telicent-io/telicent-core-charts/commit/87bc3fd47de3ea44558718de0356b0cafc695068))

## [0.3.3](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.3.2...telicent-core-v0.3.3) (2025-08-13)


### Bug Fixes

* helm issues prior to release ([#134](https://github.com/Telicent-io/telicent-core-charts/issues/134)) ([473222f](https://github.com/Telicent-io/telicent-core-charts/commit/473222fcfe3a16cbb2a92c3f9e8d318046157346))

## [0.3.2](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.3.1...telicent-core-v0.3.2) (2025-07-22)


### Bug Fixes

* Adds TLS support for opensearch ([48750b4](https://github.com/Telicent-io/telicent-core-charts/commit/48750b4da13c3bb66cb8b9fb9b040bd494fa52f7))
* Adds TLS support for opensearch ([3453a64](https://github.com/Telicent-io/telicent-core-charts/commit/3453a646b4d1afb3a3f176bd5bc56568d561ee37))
* broken image secrets ([e44aaee](https://github.com/Telicent-io/telicent-core-charts/commit/e44aaee27e14ea442c3f9fabc627f6d01d203d18))
* istio global ([5fc74ce](https://github.com/Telicent-io/telicent-core-charts/commit/5fc74ceced4187793b85f13324965b6d0ccd4067))
* istio global ([b548f13](https://github.com/Telicent-io/telicent-core-charts/commit/b548f13e23ed33a884ea544146c7dccb6bb52987))
* Remove Jobs config ([1e72b25](https://github.com/Telicent-io/telicent-core-charts/commit/1e72b25d4d39beb0f02ded67077df3ef6dfe51fc))
* scg registry ([cae087a](https://github.com/Telicent-io/telicent-core-charts/commit/cae087a7b1ef2e890ce66d729234d5ea1f52d176))
* scg registry ([4cc15bc](https://github.com/Telicent-io/telicent-core-charts/commit/4cc15bc7d191d15af0b0425c05a16551b312c428))
* scs registry ([176353e](https://github.com/Telicent-io/telicent-core-charts/commit/176353e29836351edce47fb5060ba91cbe80b80a))
* scs registy ([813b1d3](https://github.com/Telicent-io/telicent-core-charts/commit/813b1d35cbf687b56e53102c34b52523b710de8f))
* search-ui registry ([0b241e9](https://github.com/Telicent-io/telicent-core-charts/commit/0b241e962836cb8b159c6001ae23428e2bce3ada))
* search-ui registry ([ea19e74](https://github.com/Telicent-io/telicent-core-charts/commit/ea19e741b3b2530caa475308ba3f5fbfcff3d7bd))
* Standardise truststore usage across Kafka connections ([694bd33](https://github.com/Telicent-io/telicent-core-charts/commit/694bd33d1156afe66d024327527923b3f30449a9))
* Standardise truststore usage across Kafka connections ([65c503b](https://github.com/Telicent-io/telicent-core-charts/commit/65c503bdfbb74cd8a40950be6365556767508daa))
* ui registry ([07a3d89](https://github.com/Telicent-io/telicent-core-charts/commit/07a3d893bbec37e23c20fca62cc451c8b4effd52))
* user-pref reg ([5eda15b](https://github.com/Telicent-io/telicent-core-charts/commit/5eda15b0cdfa922a37d99652ad51c922f9ffb24f))
* user-pref reg ([0cd9586](https://github.com/Telicent-io/telicent-core-charts/commit/0cd9586a3e7f1da688376a7533e369776e2c7516))
* yaml ([d828b55](https://github.com/Telicent-io/telicent-core-charts/commit/d828b551f5470ad75db03ac2cf0c4d2c584eb4b3))
* yaml ([c8cf431](https://github.com/Telicent-io/telicent-core-charts/commit/c8cf4312a6bc5827486850412cf9387369744098))

## [0.3.1](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.3.0...telicent-core-v0.3.1) (2025-07-08)


### Bug Fixes

* Add Support for Mongo TLS CA file support ([7492472](https://github.com/Telicent-io/telicent-core-charts/commit/74924721b94d123a6303d2f6ceee913c5ce05d78))
* Add Support for Mongo TLS CA file support ([6cdf7a1](https://github.com/Telicent-io/telicent-core-charts/commit/6cdf7a14acd86e4331c2aa2f79cb770ed86c4b70))

## [0.3.0](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.2.11...telicent-core-v0.3.0) (2025-07-07)


### Features

* Move virtual-service to each subchart rather than core mesh ([61cddd9](https://github.com/Telicent-io/telicent-core-charts/commit/61cddd9be105db60359950f4b0f751e6523ddbe0))
* remove core-mesh as discrete chart ([b71529e](https://github.com/Telicent-io/telicent-core-charts/commit/b71529e4ba198cc2154b6ddc4d17b2b3d16b28e4))
* tc core-mesh removed ([cb9ac1b](https://github.com/Telicent-io/telicent-core-charts/commit/cb9ac1bf5449d96cabcde7502be7cbee88d48700))

## [0.2.11](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.2.10...telicent-core-v0.2.11) (2025-06-30)


### Bug Fixes

* service port ([c02fe57](https://github.com/Telicent-io/telicent-core-charts/commit/c02fe57478d4744248c188ebd1a42be34ccc529f))

## [0.2.10](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.2.9...telicent-core-v0.2.10) (2025-06-30)


### Bug Fixes

* make volumemounts optional ([de86da6](https://github.com/Telicent-io/telicent-core-charts/commit/de86da612d71bdc6e1051fe85a8924e5623a1c9f))

## [0.2.9](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.2.8...telicent-core-v0.2.9) (2025-06-30)


### Bug Fixes

* Move if for volumes ([1230ddf](https://github.com/Telicent-io/telicent-core-charts/commit/1230ddf33ae2e8cd23cc7a9dec9a87b721d43ede))
* Move if for volumes ([6618880](https://github.com/Telicent-io/telicent-core-charts/commit/66188805870547839540887ff1aa88416e47fae0))

## [0.2.8](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.2.7...telicent-core-v0.2.8) (2025-06-30)


### Bug Fixes

* password logic ([a824aee](https://github.com/Telicent-io/telicent-core-charts/commit/a824aeeebc9d5f599f4087f153fe96fc76ba09d1))
* password logic ([cf4296b](https://github.com/Telicent-io/telicent-core-charts/commit/cf4296b7ed4cdb3ef75764515aead57949461878))

## [0.2.7](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.2.6...telicent-core-v0.2.7) (2025-06-27)


### Bug Fixes

* existing secret logic ([e74b49f](https://github.com/Telicent-io/telicent-core-charts/commit/e74b49f7f388bbbaa718857cec8032c3c9c1b252))

## [0.2.6](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.2.5...telicent-core-v0.2.6) (2025-06-27)


### Bug Fixes

* Allow openidProviderUrl to be specified ([3ca4fe7](https://github.com/Telicent-io/telicent-core-charts/commit/3ca4fe7589d84399f917937ff366156ee131bbff))

## [0.2.5](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.2.4...telicent-core-v0.2.5) (2025-06-27)


### Bug Fixes

* access populated defaults ([e9703ee](https://github.com/Telicent-io/telicent-core-charts/commit/e9703ee76def6c8aef4b022607d564934a02ed42))
* access populated defaults ([7daa341](https://github.com/Telicent-io/telicent-core-charts/commit/7daa3418606d32967d47f7f6dd597c107bb8407a))

## [0.2.4](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.2.3...telicent-core-v0.2.4) (2025-06-26)


### Bug Fixes

* Remove protocol dependency and unneeded values entry ([9f36791](https://github.com/Telicent-io/telicent-core-charts/commit/9f36791543e78d0b56b817ff35e562bbe7d2be7d))

## [0.2.3](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.2.2...telicent-core-v0.2.3) (2025-06-25)


### Bug Fixes

* updage scg config to include groupId ([acf0076](https://github.com/Telicent-io/telicent-core-charts/commit/acf0076384655f3969f1893e5f14c5c76da7c70b))
* update scg config to include groupId ([83f6fb3](https://github.com/Telicent-io/telicent-core-charts/commit/83f6fb3005b08f2b087d7ad96fe2ab689b59025a))

## [0.2.2](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.2.1...telicent-core-v0.2.2) (2025-06-25)


### Bug Fixes

* adds sane default heirachy urls ([b66c30e](https://github.com/Telicent-io/telicent-core-charts/commit/b66c30e4de9716f3daad33f177c1053dcd3c8991))
* adds sane default heirachy urls ([acecf99](https://github.com/Telicent-io/telicent-core-charts/commit/acecf99cefb2d1eba52eb0d02b81175647ba2804))

## [0.2.1](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.2.0...telicent-core-v0.2.1) (2025-06-24)


### Bug Fixes

* duplicate keys ([e00e784](https://github.com/Telicent-io/telicent-core-charts/commit/e00e784056a7646732941a4dc5a52ff421fd52ec))
* duplicate keys ([03f517f](https://github.com/Telicent-io/telicent-core-charts/commit/03f517fb123c2c3b4ef79f8d674794c22a572c95))

## [0.2.0](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.1.1...telicent-core-v0.2.0) (2025-06-24)


### Features

* make helm hooks disabled by default ([2d2f5a4](https://github.com/Telicent-io/telicent-core-charts/commit/2d2f5a4351eff00fb8e5257ada6424a3bac89f7b))
* make helm hooks disabled by default ([0224308](https://github.com/Telicent-io/telicent-core-charts/commit/022430830efaf0030b3bbdb68104ed9b0ddbba17))

## [0.1.1](https://github.com/Telicent-io/telicent-core-charts/compare/telicent-core-v0.1.0...telicent-core-v0.1.1) (2025-06-24)


### Bug Fixes

* duplicate label keys ([493aac6](https://github.com/Telicent-io/telicent-core-charts/commit/493aac686cb0bfdc32f490d07f216ab518e60a64))
* duplicate label keys ([6976869](https://github.com/Telicent-io/telicent-core-charts/commit/69768696e91561a2c8ad32d30a8a66c26229311c))
